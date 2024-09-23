import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/task/domain/entities/task.dart';
import 'package:taskmgmt/features/task/domain/repositories/task_repository.dart';

class AddTaskUsecase {
  final TaskRepository taskRepository;

  AddTaskUsecase(this.taskRepository);

  Future<Either<Failure, void>> call(TaskEntity task) {
    return taskRepository.addTask(task);
  }
}
