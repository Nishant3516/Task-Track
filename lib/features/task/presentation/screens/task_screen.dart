import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmgmt/features/task/domain/entities/task.dart';
import 'package:taskmgmt/features/task/presentation/bloc/task_bloc.dart';
import 'package:taskmgmt/features/task/presentation/screens/add_edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _priorityFilter = 'all';
  bool? _statusFilter;

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetTasksRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TasksLoaded) {
            return _buildTaskList(state.tasks);
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No tasks found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditTaskScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList(List<TaskEntity> tasks) {
    final filteredTasks = tasks
        .where((task) =>
            (_priorityFilter == 'all' || task.priority == _priorityFilter) &&
            (_statusFilter == null || task.isCompleted == _statusFilter))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) => _toggleTaskCompletion(task),
            ),
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPriorityIndicator(task.priority),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () =>
                      _navigateToAddEditTaskScreen(context, task: task),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTask(task),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriorityIndicator(String priority) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  void _navigateToAddEditTaskScreen(BuildContext context,
      {TaskEntity? task}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditTaskScreen(task: task)),
    );
    if (result == true) {
      context.read<TaskBloc>().add(GetTasksRequested());
    }
  }

  void _toggleTaskCompletion(TaskEntity task) {
    final updatedTask = TaskEntity(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: !task.isCompleted,
      priority: task.priority,
      dueDate: task.dueDate,
    );
    context.read<TaskBloc>().add(AddTaskRequested(updatedTask));
  }

  void _deleteTask(TaskEntity task) {
    context.read<TaskBloc>().add(DeleteTaskRequested(task.id));
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Tasks'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _priorityFilter,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: ['all', 'low', 'medium', 'high'].map((String priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(
                        priority == 'all' ? 'All' : priority.toUpperCase()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _priorityFilter = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<bool?>(
                value: _statusFilter,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('All')),
                  DropdownMenuItem(value: false, child: Text('Incomplete')),
                  DropdownMenuItem(value: true, child: Text('Complete')),
                ],
                onChanged: (bool? newValue) {
                  setState(() {
                    _statusFilter = newValue;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<TaskBloc>().add(FilterTasksRequested(
                      priority:
                          _priorityFilter == 'all' ? null : _priorityFilter,
                      isCompleted: _statusFilter,
                    ));
              },
            ),
          ],
        );
      },
    );
  }
}
