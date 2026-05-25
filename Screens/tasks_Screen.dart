import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/core/components/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool isLoading = false;
  List<TaskModel> todoTasks = [];
  @override
  void initState() {
    super.initState();

    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((e) => !e.isDone)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        todoTasks.removeWhere((tasks) => tasks.id == id);
      });
      final updatedTask = tasks.map((e) => e.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Do Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : TaskListWidget(
                tasks: todoTasks,
                onTap: (value, index) async {
                  setState(() {
                    todoTasks[index!].isDone = value ?? false;
                  });

                  final allData = PreferencesManager().getString('tasks');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((e) => TaskModel.fromJson(e))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == todoTasks[index!].id,
                    );
                    allDataList[newIndex] = todoTasks[index!];
                    PreferencesManager().setString(
                      'tasks',
                      jsonEncode(allDataList),
                    );
                    _loadTask();
                  }
                },
                emptyMessage: 'No Tasks Found',
                onDelete: (int? id) {
                  _deleteTask(id);
                },
                onEdit: () {
                  _loadTask();
                },
              ),
      ),
    );
  }
}
