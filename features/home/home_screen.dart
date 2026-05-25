import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskyapp/Screens/add_task_screen.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/features/home/components/achieved_tasks_widget.dart';
import 'package:taskyapp/features/home/components/high_priority_task_widget.dart';
import 'package:taskyapp/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  bool isLoading = false;
  List<TaskModel> tasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;
  String? quote;
    String? userImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
    _loadQuote();
    _loadUserImage() ;
  }

  void _loadUserName() async {
    setState(() {
      username = PreferencesManager().getString('username');
    });
  }

  void _loadUserImage() async {
    setState(() {
      userImagePath = PreferencesManager().getString('user_image');
    });
  }
  void _loadQuote() async {
    setState(() {
      quote = PreferencesManager().getString('quote');
    });
  }

  _calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTask = PreferencesManager().getString('tasks');

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculatePercentage();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercentage();
    });
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  _deleteTask(int? id) async {
    if (id == null) return;

    setState(() {
      tasks.removeWhere((tasks) => tasks.id == id);
      _calculatePercentage();
    });
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                     CircleAvatar(
                    backgroundImage: userImagePath == null
                        ? AssetImage('assets/images/Thumbnail.png')
                        : FileImage(File(userImagePath!)),
                    backgroundColor: Colors.transparent,
                  
                  ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening ,$username ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            quote ?? 'One task at a time.One step closer.',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Text(
                    'Yuhuu ,Your work Is ',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done !  ',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      CustomSvgPicture.withOutColorFilter(
                        path: 'assets/images/waving-hand.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasksWidget(
                    totalDoneTasks: totalDoneTasks,
                    totalTasks: totalTasks,
                    percentage: percentage,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTaskWidget(
                    tasks: tasks.where((e) => e.isHighPriority).toList(),
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 16),
                    child: Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No tasks yet!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },

                    emptyMessage: '',
                    onDelete: (int? id) {
                      _deleteTask(id);
                    },
                    onEdit: () {
                      _loadTask();
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );

            if (result != null && result) {
              _loadTask();
            }
          },

          label: Text('Add New Task'),
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
        ),
      ),
    );
  }
}
