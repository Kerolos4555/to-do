abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeNavBarState extends AppStates {
  final int currentIndex;
  ChangeNavBarState({required this.currentIndex});
}

class CreateDatabaseState extends AppStates {}

class GetDatabaseState extends AppStates {}

class InsertDatabaseState extends AppStates {}

class UpdateDataBaseState extends AppStates {}

class DeleteDataFromDatabaseState extends AppStates {}

class ChangeBottomSheetState extends AppStates {}
