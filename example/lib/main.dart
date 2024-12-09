import 'package:example/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siimple/siimple.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = Database();
  await db.initialize();

  // final users = db.collection('users');
  // // users.create({
  // //   'name': 'mike',
  // //   'age': 25,
  // //   'email': 'alice@example.com',
  // // });

  // final documents = users.getAll();
  // for (var document in documents) {
  //   log("$document");
  // }

  runApp(RepositoryProvider(
    create: (context) => db,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(context.read<Database>()),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
