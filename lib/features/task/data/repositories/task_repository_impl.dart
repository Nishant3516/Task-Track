import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:taskmgmt/core/errors/failures.dart';
import 'package:taskmgmt/features/task/data/models/task_model.dart';
import 'package:taskmgmt/features/task/domain/entities/task.dart';
import 'package:taskmgmt/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final FirebaseFirestore firestore;

  TaskRepositoryImpl(this.firestore);

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isCompleted: task.isCompleted,
        dueDate: task.dueDate,
        priority: task.priority,
      );
      await firestore
          .collection('tasks')
          .doc(task.id)
          .set(taskModel.toFirestore());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await firestore.collection('tasks').doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final query = await firestore.collection('tasks').get();

      final tasks =
          query.docs.map((doc) => TaskModel.fromFireStore(doc.data())).toList();
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
