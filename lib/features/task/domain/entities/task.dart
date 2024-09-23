class TaskEntity {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String dueDate;
  final String priority;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
    required this.priority,
  });
}
