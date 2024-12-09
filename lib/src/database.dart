// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import './collection.dart';

class Database {
  final String fileName;
  late String filePath;
  final Map<String, Collection> _collections = {};

  Database({this.fileName = "siimple.json"});

  Future<File> _initializeFile() async {
    final directory = await getApplicationDocumentsDirectory();
    filePath = '${directory.path}/$fileName';
    return File(filePath);
  }

  Future<void> initialize() async {
    final file = await _initializeFile();
    if (await file.exists()) {
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
    } else {
      // Initialize empty database
      await save();
    }
  }

  Future<void> save() async {
    final data = {
      'collections': _collections
          .map((name, collection) => MapEntry(name, collection.toJson())),
    };
    final file = File(filePath);
    await file.writeAsString(jsonEncode(data));
  }

  Collection collection(String name) {
    return _collections.putIfAbsent(name, () => Collection(name, this));
  }
}
