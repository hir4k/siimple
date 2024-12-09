import 'package:example/cubit/todo_cubit.dart';
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
    return BlocProvider(
      create: (context) => TodoCubit(context.read<Database>())..list(),
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
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<TodoCubit>();
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller,
                        ),
                        TextButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              cubit.create(controller.text);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<TodoCubit, List<Document>>(
        builder: (context, docs) {
          if (docs.isEmpty) {
            return const Center(
              child: Text('No todos'),
            );
          }

          if (docs.isNotEmpty) {
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(docs[index].data['text']),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
