import 'package:bloc/bloc.dart';
import 'package:example/shared/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc(this.repository) : super(CreateTodoInitial()) {
    on<CreateTodoPressed>((event, emit) async {
      emit(CreateTodoLoading());
      try {
        await repository.create(event.text);
        emit(CreateTodoSuccess());
      } catch (e) {
        emit(CreateTodoFail());
      }
    });
  }

  final TodoRepository repository;
}
