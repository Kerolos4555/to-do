import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';
import 'package:todo_list_app/cubits/app_cubit/states.dart';
import 'package:todo_list_app/widgets/floating_action_button.dart';
import 'package:todo_list_app/widgets/navigation_bar.dart';

class HomeLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is InsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                AppCubit.get(context)
                    .titles[AppCubit.get(context).currentIndex],
              ),
            ),
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
            floatingActionButton: CustomFloatingActionButton(
              formKey: formKey,
              scaffoldKey: scaffoldKey,
              titleController: titleController,
              dateController: dateController,
              timeController: timeController,
            ),
            bottomNavigationBar: CustomNavigationBar(
              key: ValueKey(AppCubit.get(context).currentIndex),
            ),
          );
        },
      ),
    );
  }
}
