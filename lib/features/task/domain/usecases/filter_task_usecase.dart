import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import '../repositories/task_repository.dart';
import '../entities/task.dart';

class FilterTasksUseCase {
  final TaskRepository repository;

  FilterTasksUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call({
    String? priority,
    bool? isCompleted,
  }) async {
    final tasksOrFailure = await repository.getTasks();
    return tasksOrFailure.fold(
      (failure) => Left(failure),
      (tasks) {
        final filteredTasks = tasks.where((task) {
          bool matchesPriority = priority == null || task.priority == priority;
          bool matchesStatus =
              isCompleted == null || task.isCompleted == isCompleted;
          return matchesPriority && matchesStatus;
        }).toList();
        return Right(filteredTasks);
      },
    );
  }
}
