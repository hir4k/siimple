// ignore: depend_on_referenced_packages
import 'dart:developer';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:siimple/siimple.dart';

class TodoCubit extends Cubit<List<Document>> {
  TodoCubit(this.db) : super([]) {
    todoCollection = db.collection('todos');
  }

  final Database db;
  late Collection todoCollection;

  list() {
    log("list called");
    final docs = todoCollection.getAll();
    log(docs.length.toString());
    emit(docs);
  }

  create(String text) {
    todoCollection.create({'text': text});
    list();
  }
}
