import 'package:example/todos/bloc/todos_bloc.dart';
import 'package:example/shared/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosListview extends StatelessWidget {
  const TodosListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodosBloc(context.read<TodoRepository>())..add(TodosListViewLoaded()),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is TodosLoadSuccess) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todos[index].text),
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
