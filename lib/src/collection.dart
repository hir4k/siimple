import 'package:uuid/uuid.dart';

import './database.dart';
import './document.dart';

class Collection {
  final String name;
  final List<Document> _documents = [];
  final Database database;

  Collection(this.name, this.database);

  Document create(Map<String, dynamic> data) {
    final id = Uuid().v4();
    final document = Document(id, data);
    _documents.add(document);
    database.save();
    return document;
  }

  List<Document> getAll({Map<String, dynamic>? filters}) {
    if (filters == null || filters.isEmpty) return _documents;

    List<Document> results = [];

    for (var doc in _documents) {
      bool matched = true;
      for (var filter in filters.entries) {
        if (doc.data[filter.key] != filter.value) {
          matched = false;
          break;
        }
      }
      if (matched) {
        results.add(doc);
      }
    }

    return results;
  }

  Document? get(String id) {
    return _documents.firstWhere((doc) => doc.id == id);
  }

  void update(String id, Map<String, dynamic> newData) {
    var document = get(id);
    if (document != null) {
      document.data = newData;
      database.save();
    }
  }

  void delete(String id) {
    _documents.removeWhere((doc) => doc.id == id);
    database.save();
  }

  Map<String, dynamic> toJson() {
    return {
      'documents': _documents.map((doc) => doc.toJson()).toList(),
    };
  }

  static Collection fromJson(
      String name, Map<String, dynamic> json, Database database) {
    final collection = Collection(name, database);
    final documents = (json['documents'] as List)
        .map((docJson) => Document.fromJson(docJson))
        .toList();
    collection._documents.addAll(documents);
    return collection;
  }
}
