import 'package:flutter/material.dart';
import 'package:taskyapp/features/tasks/high_priority_screen.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/models/task_model.dart';

class HighPriorityTaskWidget extends StatelessWidget {
  const HighPriorityTaskWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(
                      color: Color(0xff15B86C),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                ...tasks.where((e) => e.isHighPriority).take(4).map((e) {
                  return Row(
                    children: [
                      CustomCheckBox(
                        value: e.isDone,
                        onChanged: (bool? value) async {
                          final index = tasks.indexWhere(
                            (element) => element.id == e.id,
                          );
                          onTap(value, index);
                        },
                      ),

                      Flexible(
                        child: Text(
                          e.taskName,
                          style: e.isDone
                              ? Theme.of(context).textTheme.titleLarge
                              : Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityScreen();
                  },
                ),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(color: Color(0xff6E6E6E)),
                ),
                child: CustomSvgPicture(
                  path: 'assets/images/arrow_up.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
