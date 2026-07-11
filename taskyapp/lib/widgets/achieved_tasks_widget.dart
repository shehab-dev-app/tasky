import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    required this.totalTasks,
    required this.totalDoneTasks,
    required this.percentage,
  });
  final int totalTasks;
  final int totalDoneTasks;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                '$totalDoneTasks Out of $totalTasks Done',
                style: Theme.of(context).textTheme.titleSmall
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: pi / -2,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    value: percentage,
                    backgroundColor: Color(0xff6D6D6D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff15B86C),
                    ),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ],
          ),
        ],
      ),
    );
  }
}
