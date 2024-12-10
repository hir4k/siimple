import 'package:example/create_todo/bloc/create_todo_bloc.dart';
import 'package:example/shared/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoButton extends StatefulWidget {
  const CreateTodoButton({super.key});

  @override
  State<CreateTodoButton> createState() => _CreateTodoButtonState();
}

class _CreateTodoButtonState extends State<CreateTodoButton> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoBloc(context.read<TodoRepository>()),
      child: BlocBuilder<CreateTodoBloc, CreateTodoState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              final bloc = context.read<CreateTodoBloc>();
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
                                  bloc.add(CreateTodoPressed(controller.text));
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
            child: state is CreateTodoLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : const Center(child: Icon(Icons.add)),
          );
        },
      ),
    );
  }
}
