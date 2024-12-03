import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Simple {
  Simple._internal(String path) {
    _file = File(path);
  }

  static Simple? _instance;
  late final File _file;

  static Future<Simple> get instance async {
    if (_instance == null) {
      final directory = await _getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/_simpledb';
      final db = Simple._internal(filePath);
      // Create the file if it doesn't exist
      if (!await db._file.exists()) {
        await db._file.create(recursive: true);
      }

      return db;
    }

    return _instance!;
  }

  Future<void> logLines() async {
    final lines = await _file.readAsLines();
    for (var line in lines) {
      log(line.toString());
    }
  }

  // Insert or update the value if the key exists
  Future<void> set(String key, String value) async {
    final lines = await _file.readAsLines();
    bool keyExists = false;
    final newLines = lines.map((line) {
      final parts = line.split(':');
      if (parts[0] == key) {
        keyExists = true;
        return '$key:$value'; // Update existing key
      }
      return line; // Keep existing lines unchanged
    }).toList();

    if (!keyExists) {
      newLines.add('$key:$value'); // Add new entry if key doesn't exist
    }

    // Rewrite the entire file with updated or new data
    await _file.writeAsString('${newLines.join('\n')}\n');
  }

  // Retrieve value by key
  Future<String?> get(String key) async {
    final lines = await _file.readAsLines();
    for (var line in lines) {
      final parts = line.split(':');
      if (parts[0] == key) {
        return parts[1];
      }
    }
    return null;
  }

  // Delete a key-value pair by key
  Future<void> delete(String key) async {
    final lines = await _file.readAsLines();
    final newLines = lines.where((line) {
      final parts = line.split(':');
      return parts[0] != key; // Keep only lines where key does not match
    }).toList();

    // Rewrite the file with the remaining lines
    await _file.writeAsString('${newLines.join('\n')}\n');
  }

  // Helper function to get the application document directory
  static Future<Directory> _getApplicationDocumentsDirectory() async {
    // This simulates getting the document directory. Replace it with actual Flutter implementation.
    // return Directory.systemTemp; // Replace with `getApplicationDocumentsDirectory` for Flutter apps.
    return getApplicationDocumentsDirectory(); // Replace with `getApplicationDocumentsDirectory` for Flutter apps.
  }
}
