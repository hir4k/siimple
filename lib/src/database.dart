import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './collection.dart';
import 'file_lock.dart';

class Siimple {
  Siimple({this.fileName = "siimple.json"});

  final String fileName;
  late String _filePath;
  final Map<String, Collection> _collections = {};
  late FileLock _fileLock;

  Future<void> _initializeLockFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _fileLock = FileLock("${directory.path}/siigma.lock");
  }

  Future<File> _initializeDbFile() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      _filePath = '${directory.path}/$fileName';
      return File(_filePath);
    }

    throw Exception("This package is not available to use in this platform.");
  }

  Future<void> initialize() async {
    await _initializeLockFile();
    final file = await _initializeDbFile();

    if (!await file.exists()) {
      // Initialize empty database
      await save();
      return;
    }

    final content = await file.readAsString();
    final jsonData = jsonDecode(content) as Map<String, dynamic>;
    final collections = jsonData['collections'] as Map<String, dynamic>;
    for (var entry in collections.entries) {
      _collections[entry.key] = Collection.fromJson(
        entry.key,
        entry.value,
        this,
      );
    }
  }

  Future<void> save() async {
    await _fileLock.lock();
    try {
      final data = {
        'collections': _collections
            .map((name, collection) => MapEntry(name, collection.toJson())),
      };
      final file = File(_filePath);
      await file.writeAsString(jsonEncode(data));
    } finally {
      await _fileLock.unlock();
    }
  }

  Collection collection(String name) {
    return _collections.putIfAbsent(name, () => Collection(name, this));
  }
}
