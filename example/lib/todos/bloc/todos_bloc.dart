import 'package:bloc/bloc.dart';
import 'package:example/todos/todo_model.dart';
import 'package:example/shared/todo_repository.dart';
import 'package:meta/meta.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc(this.repository) : super(TodosInitial()) {
    on<TodosListViewLoaded>((event, emit) async {
      emit(TodosLoading());
      try {
        add(TodosSubscriptionRequested());
        repository.list();
      } catch (e) {
        emit(TodosLoadFail());
      }
    });

    on<TodosSubscriptionRequested>((event, emit) async {
      await emit.forEach(
        repository.stream,
        onData: (todos) => TodosLoadSuccess(todos),
        onError: (error, stackTrace) => TodosLoadFail(),
      );
    });
  }

  final TodoRepository repository;
}
