class TaskModel {
  int id;
  String taskName;
  String taskDescription;
  bool isDone;
  bool isHighPriority;

  TaskModel({
    required this.id,
    required this.taskName,
    this.taskDescription = '',
    this.isDone = false,
    this.isHighPriority = false,
  });

  // Convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isDone': isDone,
      'isHighPriority': isHighPriority,
    };
  }

  // Create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      taskName: json['taskName'] ?? '',
      taskDescription: json['taskDescription'] ?? '',
      isDone: json['isDone'] ?? false,
      isHighPriority: json['isHighPriority'] ?? false,
    );
  }
}
