import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/cubits/bloc_observer.dart';
import 'package:todo_list_app/layouts/home_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
