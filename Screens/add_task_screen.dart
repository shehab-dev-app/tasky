import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';
import 'package:taskyapp/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<AddTaskScreen> {
  ///TODO : dispose those controllers
  final TextEditingController taskController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: taskController,
                    hintText: 'Finish UI design for login screen',
                    validator: (String? task) {
                      if (task == null || task.trim().isEmpty) {
                        return 'please enter the task';
                      }
                      return null;
                    },
                    title: 'Task Name',
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: "Task Description",
                    controller: taskDescriptionController,
                    maxLines: 5,
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "High Priority  ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0XFFFFFCFC),
                        ),
                      ),
                      Switch(
                        value: isHighPriority,
                        onChanged: (value) => setState(() {
                          isHighPriority = value;
                        }),
                      ),
                    ],
                  ),
                ],
              ),

              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    final taskJson = PreferencesManager().getString('tasks');

                    List<dynamic> listTasks = [];
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }
                    TaskModel model = TaskModel(
                      id: listTasks.length + 1,
                      taskName: taskController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    listTasks.add(model.toJson());

                    final taskEncode = jsonEncode(listTasks);
                    await PreferencesManager().setString('tasks', taskEncode);

                    Navigator.of(context).pop(true);
                  }
                },

                label: Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFCFC),
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                icon: Icon(Icons.add, color: Color(0xffFFFCFC)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
