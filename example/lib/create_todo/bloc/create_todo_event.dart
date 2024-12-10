part of 'create_todo_bloc.dart';

@immutable
sealed class CreateTodoEvent {}

class CreateTodoPressed extends CreateTodoEvent {
  final String text;

  CreateTodoPressed(this.text);
}
