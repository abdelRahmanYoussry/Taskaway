
import 'package:algorizainternship/FirstTask(OnBoardingLogin,Register)/Componets/Componets.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/Divider.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/FullTaskWidget.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/TasksWidget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/ElevatedButton.dart';
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
            height: mediaQuery.height/8,
            addTask: true,
            list: AppCubit.get(context).allTasks,
            buttonHeight: mediaQuery.height/16,
            isChecked: isChecked,
            );
      },
    );
  }
}
