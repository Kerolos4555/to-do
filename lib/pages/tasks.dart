import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';
import 'package:todo_list_app/cubits/app_cubit/states.dart';
import 'package:todo_list_app/widgets/tasks_list_builder.dart';

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map> newTasks = AppCubit.get(context).tasks;
        return TasksListBuilder(
          tasksList: newTasks,
        );
      },
    );
  }
}
