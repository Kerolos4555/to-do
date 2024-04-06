import 'package:flutter/material.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';

class TaskItem extends StatelessWidget {
  final Map model;
  const TaskItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  id: model['id'],
                  status: 'done',
                );
              },
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  id: model['id'],
                  status: 'archived',
                );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
