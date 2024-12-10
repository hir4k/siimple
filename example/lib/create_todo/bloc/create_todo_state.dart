part of 'create_todo_bloc.dart';

@immutable
sealed class CreateTodoState {}

final class CreateTodoInitial extends CreateTodoState {}

class CreateTodoLoading extends CreateTodoState {}

class CreateTodoSuccess extends CreateTodoState {}

class CreateTodoFail extends CreateTodoState {}
