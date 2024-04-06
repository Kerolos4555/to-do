class TaskModel {
  final int id;
  final String title;
  final String date;
  final String time;
  final String status;

  const TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
  });

  factory TaskModel.fromSql(dynamic task) {
    return TaskModel(
      id: task['id'],
      title: task['title'],
      date: task['date'],
      time: task['time'],
      status: task['status'],
    );
  }
}
