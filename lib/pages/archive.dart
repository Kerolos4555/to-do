import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';
import 'package:todo_list_app/cubits/app_cubit/states.dart';
import 'package:todo_list_app/widgets/tasks_list_builder.dart';

class ArchiveBody extends StatelessWidget {
  const ArchiveBody({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map> archivedTasks = AppCubit.get(context).archivedTasks;
        return TasksListBuilder(
          tasksList: archivedTasks,
        );
      },
    );
  }
}
