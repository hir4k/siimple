import "dart:convert";
import "dart:io";

import "collection.dart";
import "file_lock.dart";

class Siimple {
  Siimple({
    required this.path,
    this.name = "siimple.json",
    this.lockFileName = "siimple.lock",
  });

  final String path;
  final String name;
  final String lockFileName;
  final Map<String, Collection> _collections = {};
  late FileLock _fileLock;

  Future<void> initialize() async {
    _fileLock = FileLock("$path/$lockFileName");

    final file = File("$path/$name");

    if (!await file.exists()) {
      // Initialize empty database
      await save();
      return;
    }

    await _loadCollectionsFromDisk(file);
  }

  Future<void> _loadCollectionsFromDisk(File file) async {
    final content = await file.readAsString();
    final jsonData = jsonDecode(content) as Map<String, dynamic>;
    final collections = jsonData["collections"] as Map<String, dynamic>;
    for (var entry in collections.entries) {
      _collections[entry.key] = Collection.fromJson(
        entry.key,
        entry.value,
        this,
      );
    }
  }

  /// This will save the database to the disk
  Future<void> save() async {
    await _fileLock.lock();
    try {
      final data = {
        "collections": _collections.map(
          (name, collection) => MapEntry(
            name,
            collection.toJson(),
          ),
        ),
      };
      final file = File("$path/$name");
      await file.writeAsString(jsonEncode(data));
    } finally {
      await _fileLock.unlock();
    }
  }

  /// Create or get a collection
  Collection collection(String name) {
    return _collections.putIfAbsent(name, () => Collection(name, this));
  }

  Future<void> transaction(Future<void> Function() operations) async {
    final journalPath = "$path/siimple.journal";
    final journalFile = File(journalPath);

    // Save the current state to the journal
    await journalFile.writeAsString(jsonEncode(_collections));

    try {
      // Perform the operations in memory
      await operations();

      // Save the updated state to the main file
      await save();

      // Clear the journal on success
      if (await journalFile.exists()) {
        await journalFile.delete();
      }
    } catch (e) {
      // Rollback to the state in the journal in case of an error
      if (await journalFile.exists()) {
        await _loadCollectionsFromDisk(File(journalPath));
        await save();
        await journalFile.delete();
      }
      rethrow;
    }
  }
}
