part of 'todos_bloc.dart';

@immutable
sealed class TodosEvent {}

class TodosListViewLoaded extends TodosEvent {}

class TodosSubscriptionRequested extends TodosEvent {}
