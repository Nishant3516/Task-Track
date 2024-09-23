import 'package:taskmgmt/features/task/domain/entities/task.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required String priority,
    required String dueDate,
  }) : super(
            id: id,
            title: title,
            description: description,
            isCompleted: isCompleted,
            dueDate: dueDate,
            priority: priority);

  factory TaskModel.fromFireStore(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      isCompleted: data['isCompleted'],
      priority: data['priority'],
      dueDate: data['dueDate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority,
      'dueDate': dueDate,
    };
  }
}
