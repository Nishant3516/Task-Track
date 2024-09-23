import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmgmt/features/task/domain/entities/task.dart';
import 'package:taskmgmt/features/task/domain/usecases/add_task_usecase.dart';
import 'package:taskmgmt/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:taskmgmt/features/task/domain/usecases/filter_task_usecase.dart';
import 'package:taskmgmt/features/task/domain/usecases/get_tasks_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUsecase addTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final GetTasksUsecase getTasksUseCase;
  final FilterTasksUseCase filterTasksUseCase;

  TaskBloc({
    required this.addTaskUsecase,
    required this.deleteTaskUsecase,
    required this.getTasksUseCase,
    required this.filterTasksUseCase,
  }) : super(TaskInitial()) {
    on<AddTaskRequested>((event, emit) async {
      emit(TasksLoading());
      final failureOrSuccess = await addTaskUsecase.call(event.task);

      await failureOrSuccess.fold(
        (failure) async {
          emit(TaskError(failure.message));
        },
        (_) async {
          emit(TaskAdded());
          final failureOrTasks = await getTasksUseCase.call();
          await failureOrTasks.fold(
            (failure) async {
              emit(TaskError(failure.message));
            },
            (tasks) async {
              emit(TasksLoaded(tasks));
            },
          );
        },
      );
    });

    on<DeleteTaskRequested>((event, emit) async {
      emit(TasksLoading());
      final failureOrSuccess = await deleteTaskUsecase.call(event.id);

      await failureOrSuccess.fold(
        (failure) async {
          emit(TaskError(failure.message));
        },
        (_) async {
          emit(TaskDeleted());
          final failureOrTasks = await getTasksUseCase.call();
          await failureOrTasks.fold(
            (failure) async {
              emit(TaskError(failure.message));
            },
            (tasks) async {
              emit(TasksLoaded(tasks));
            },
          );
        },
      );
    });

    on<GetTasksRequested>((event, emit) async {
      emit(TasksLoading());
      final failureOrTasks = await getTasksUseCase.call();
      await failureOrTasks.fold(
        (failure) async {
          emit(TaskError(failure.message));
        },
        (tasks) async {
          emit(TasksLoaded(tasks));
        },
      );
    });

    on<FilterTasksRequested>((event, emit) async {
      emit(TasksLoading());
      final failureOrFilteredTasks = await filterTasksUseCase.call(
        priority: event.priority,
        isCompleted: event.isCompleted,
      );
      await failureOrFilteredTasks.fold(
        (failure) async {
          emit(TaskError(failure.message));
        },
        (filteredTasks) async {
          emit(TasksLoaded(filteredTasks));
        },
      );
    });
  }
}
