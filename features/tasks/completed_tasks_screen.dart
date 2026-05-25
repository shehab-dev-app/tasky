import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/widgets/task_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  bool isLoading = false;
  List<TaskModel> completedTasks = [];
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
        completedTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((e) => e.isDone)
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
        completedTasks.removeWhere((tasks) => tasks.id == id);
      });
      final updatedTask = tasks.map((e) => e.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : TaskListWidget(
                tasks: completedTasks,
                onTap: (value, index) async {
                  setState(() {
                    completedTasks[index!].isDone = value ?? false;
                  });
                  final allData = PreferencesManager().getString('tasks');

                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((e) => TaskModel.fromJson(e))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == completedTasks[index!].id,
                    );
                    allDataList[newIndex] = completedTasks[index!];

                    await PreferencesManager().setString(
                      'tasks',
                      jsonEncode(allDataList),
                    );

                    _loadTask();
                  }
                },
                emptyMessage: 'No Tasks completed',
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
