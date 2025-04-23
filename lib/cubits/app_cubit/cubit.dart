import 'package:flutter/material.dart';
import 'package:todo_list_app/cubits/app_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/pages/archive.dart';
import 'package:todo_list_app/pages/done.dart';
import 'package:todo_list_app/pages/tasks.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    TaskBody(),
    DoneBody(),
    ArchiveBody(),
  ];

  List<String> titles = const [
    'Tasks',
    'Done',
    'Archived',
  ];

  late Database database;

  List<Map> tasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  bool isBottomSheetShown = false;

  IconData fabIcon = Icons.edit;

  void changeIndex(int index) {
    currentIndex = index;
    emit(
      ChangeNavBarState(
        currentIndex: currentIndex,
      ),
    );
  }

  void changeBottomSheetState({required bool isShown, required IconData icon}) {
    isBottomSheetShown = isShown;
    fabIcon = icon;

    emit(ChangeBottomSheetState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) {
        db
            .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
            )
            .then((value) => emit(CreateDatabaseState()))
            .catchError((error) =>
                debugPrint('error in creating database ${error.toString()}'));
      },
      onOpen: (database) async {
        try {
          tasks = await getData(database);
        } catch (error) {
          debugPrint('Error in opening database ${error.toString()}');
        }
      },
    ).then((value) {
      database = value;
    }).catchError((error) {
      debugPrint('Error opening database: ${error.toString()}');
    });
  }

  Future<List<Map>> getData(Database db) async {
    tasks = [];
    doneTasks = [];
    archivedTasks = [];
    List<Map> tasksList = await db.rawQuery('SELECT * FROM tasks');
    for (int i = 0; i < tasksList.length; i++) {
      if (tasksList[i]['status'] == 'new') {
        tasks.add(tasksList[i]);
      } else if (tasksList[i]['status'] == 'done') {
        doneTasks.add(tasksList[i]);
      } else {
        archivedTasks.add(tasksList[i]);
      }
    }
    emit(GetDatabaseState());
    return tasksList;
  }

  Future<void> insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    try {
      await database.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")');
        emit(InsertDatabaseState());
      });
      await getData(database);
    } catch (error) {
      debugPrint('Error when inserting data to database ${error.toString()}');
    }
  }

  void updateData({
    required int id,
    required String status,
  }) async {
    try {
      await database.rawUpdate(
          'UPDATE tasks SET status = ? WHERE id = ?', [status, '$id']);
      getData(database);
      emit(UpdateDataBaseState());
    } catch (error) {
      debugPrint('Error when update the data ${error.toString()}');
    }
  }

  void deleteData({
    required int id,
  }) async {
    try {
      await database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']);
      getData(database);
      emit(DeleteDataFromDatabaseState());
    } catch (error) {
      debugPrint('Error When Deleting a task ${error.toString()}');
    }
  }
}
