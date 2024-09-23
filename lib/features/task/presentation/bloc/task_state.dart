part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TasksLoading extends TaskState {}

final class TaskAdded extends TaskState {}

final class TaskDeleted extends TaskState {}

final class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}

final class TasksLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TasksLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
