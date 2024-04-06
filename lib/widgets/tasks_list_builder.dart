import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/task_item.dart';

class TasksListBuilder extends StatelessWidget {
  final List<Map> tasksList;
  const TasksListBuilder({super.key, required this.tasksList});

  @override
  Widget build(BuildContext context) {
    if (tasksList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 100,
            ),
            Text(
              'No tasks yet, Please add some tasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.separated(
        itemBuilder: (context, index) {
          return TaskItem(
            model: tasksList[index],
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          );
        },
        itemCount: tasksList.length,
      );
    }
  }
}
