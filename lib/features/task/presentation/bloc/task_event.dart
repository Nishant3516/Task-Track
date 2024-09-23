part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskRequested extends TaskEvent {
  final TaskEntity task;

  const AddTaskRequested(this.task);
}

class DeleteTaskRequested extends TaskEvent {
  final String id;

  const DeleteTaskRequested(this.id);
}

class GetTasksRequested extends TaskEvent {}

class FilterTasksRequested extends TaskEvent {
  final String? priority;
  final bool? isCompleted;

  const FilterTasksRequested({this.priority, this.isCompleted});
}
