import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/task/domain/repositories/task_repository.dart';

class DeleteTaskUsecase {
  final TaskRepository taskRepository;

  DeleteTaskUsecase(this.taskRepository);

  Future<Either<Failure, void>> call(String id) {
    return taskRepository.deleteTask(id);
  }
}
