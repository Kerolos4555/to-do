import 'package:flutter/material.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        AppCubit.get(context).changeIndex(index);
      },
      currentIndex: AppCubit.get(context).currentIndex,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.done,
          ),
          label: 'Done',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.archive_outlined,
          ),
          label: 'Archive',
        ),
      ],
    );
  }
}
