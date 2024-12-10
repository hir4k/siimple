import 'package:example/todos/todo_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:siimple/siimple.dart';

class TodoRepository {
  TodoRepository(this.db) {
    todoCollection = db.collection('todos');
    _controller = BehaviorSubject.seeded([]);
  }

  final Siimple db;
  late Collection todoCollection;
  late BehaviorSubject<List<TodoModel>> _controller;

  Stream<List<TodoModel>> get stream => _controller.stream;

  void list() {
    final documents = todoCollection
        .query()
        .where("text__icontains", "t")
        .limit(10)
        .findAll();
    final todos = documents
        .map((doc) => TodoModel(id: doc.id, text: doc.data['text']))
        .toList();
    _controller.sink.add(todos);
  }

  void create(String text) {
    final doc = todoCollection.create({'text': text});
    final todo = TodoModel(id: doc.id, text: doc.data['text']);
    _controller.sink.add([..._controller.value, todo]);
  }
}
