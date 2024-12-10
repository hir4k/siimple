import 'package:example/create_todo/create_todo_button.dart';
import 'package:example/shared/todo_repository.dart';
import 'package:example/todos/todos_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siimple/siimple.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = Database();
  await db.initialize();

  runApp(RepositoryProvider(
    create: (context) => db,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(context.read<Database>()),
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      floatingActionButton: const CreateTodoButton(),
      body: const TodosListview(),
    );
  }
}
