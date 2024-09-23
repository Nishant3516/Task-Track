import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, void>> addTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(String id);
  Future<Either<Failure, List<TaskEntity>>> getTasks();
}
