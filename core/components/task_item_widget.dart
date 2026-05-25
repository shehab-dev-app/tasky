import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/enums/task_item_actions_enum.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/theme/theme_controller.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';
import 'package:taskyapp/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) async {
              onChanged(value);
            },
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.taskName,
                  style: TextStyle(
                    color: model.isDone
                        ? Theme.of(context).textTheme.titleLarge?.color
                        : Theme.of(context).textTheme.titleMedium?.color,
                    fontSize: 16,
                    decoration: model.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Color(0xffA0A0A0),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: TextStyle(
                      color: Color(0XFFC6C6C6),
                      fontSize: 14,
                      decoration: model.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Color(0xffA0A0A0),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);

                case TaskItemActionsEnum.delete:
                  return _showAlertDialog(context);

                case TaskItemActionsEnum.edit:
                  final result = await _showButtomSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }

                  break;
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0xffa0a0a0) : Color(0xffc6c6c6))
                  : (model.isDone ? Color(0xff6a6a6a) : Color(0xff3a4640)),
            ),
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              String label;

              if (e == TaskItemActionsEnum.markAsDone) {
                label = model.isDone ? 'Mark as Undone' : 'Mark as Done';
              } else {
                label = e.name;
              }
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(label),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('are you sure you want to delete this task'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              child: Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtomSheet(BuildContext context, TaskModel model) {
    final TextEditingController taskController = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(text: model.taskDescription);
    GlobalKey<FormState> key = GlobalKey();
    bool isHighPriority = true;
    return showModalBottomSheet<bool>(
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: key,
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
                        if (key.currentState?.validate() ?? false) {
                          final taskJson = PreferencesManager().getString(
                            'tasks',
                          );

                          List<dynamic> listTasks = [];
                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone
                          );
                          final item = listTasks.firstWhere(
                            (e) => e['id'] == model.id,
                          );

                          final int index = listTasks.indexOf(item);
                          listTasks[index] = newModel;

                          final taskEncode = jsonEncode(listTasks);
                          await PreferencesManager().setString(
                            'tasks',
                            taskEncode,
                          );

                          Navigator.of(context).pop(true);
                          // }
                        }
                      },

                      label: Text(
                        'Edit Task',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFFFCFC),
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      icon: Icon(Icons.edit, color: Color(0xffFFFCFC)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
