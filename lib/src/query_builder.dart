import 'dart:developer';
import 'package:siimple/siimple.dart';

class QueryBuilder {
  final Collection collection;
  final Map<String, dynamic> filters = {};
  Function? sorting;
  int? limit;

  QueryBuilder(this.collection);

  // Method to filter by a specific field and value
  QueryBuilder where(String field, dynamic value) {
    filters[field] = value;
    return this;
  }

  // Execute and return the results
  List<Document> findAll() {
    log("$filters");
    return collection.executeQuery(this);
  }
}
