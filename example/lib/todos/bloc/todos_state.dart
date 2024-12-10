part of 'todos_bloc.dart';

@immutable
sealed class TodosState {}

final class TodosInitial extends TodosState {}

class TodosLoading extends TodosState {}

class TodosLoadSuccess extends TodosState {
  final List<TodoModel> todos;

  TodosLoadSuccess(this.todos);
}

class TodosLoadFail extends TodosState {}
