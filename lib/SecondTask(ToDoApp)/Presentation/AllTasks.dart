

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/ElevatedButton.dart';
import '../Widget/FullTaskWidget.dart';
import 'AddTask.dart';



class AllTasksScreen extends StatelessWidget {
  AllTasksScreen({Key? key}) : super(key: key);
  bool isChecked = false;
  Color ?taskColor ;

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MyTaskFullWidget(
            height: mediaQuery.height/6,
            changeStatus: true,
            addTask: true,
            showBody: false,
            Taskslist: AppCubit.get(context).allTasks,
            buttonHeight: mediaQuery.height/16,
            isChecked: isChecked,
            );
      },
    );
  }
}
