import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';
import 'package:todo_list_app/cubits/app_cubit/states.dart';
import 'package:todo_list_app/widgets/tasks_list_builder.dart';

class DoneBody extends StatelessWidget {
  const DoneBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map> doneTasks = AppCubit.get(context).doneTasks;
        return TasksListBuilder(
          tasksList: doneTasks,
        );
      },
    );
  }
}