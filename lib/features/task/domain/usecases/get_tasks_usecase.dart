import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/task/domain/entities/task.dart';
import 'package:taskmgmt/features/task/domain/repositories/task_repository.dart';

class GetTasksUsecase {
  final TaskRepository taskRepository;

  GetTasksUsecase(this.taskRepository);

  Future<Either<Failure, List<TaskEntity>>> call() {
    return taskRepository.getTasks();
  }
}
