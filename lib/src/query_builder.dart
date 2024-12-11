import 'package:siimple/siimple.dart';

class QueryBuilder {
  final Collection collection;
  final Map<String, dynamic> filters = {};
  Function? sorting;
  int? limitCount;

  QueryBuilder(this.collection);

  // Method to filter by a specific field and value
  QueryBuilder where(String field, dynamic value) {
    filters[field] = value;
    return this;
  }

  // Limit the number of results
  QueryBuilder limit(int limitValue) {
    limitCount = limitValue;
    return this;
  }

  // Execute and return the results
  Future<List<Document>> findAll() async {
    return await collection.executeQuery(this);
  }
}
