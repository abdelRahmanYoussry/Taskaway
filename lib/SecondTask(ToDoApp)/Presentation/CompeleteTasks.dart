import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/FullTaskWidget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../FirstTask(OnBoardingLogin,Register)/Componets/Componets.dart';
import '../../FirstTask(OnBoardingLogin,Register)/Componets/ElevatedButton.dart';
import '../Widget/Divider.dart';
import '../Widget/TasksWidget.dart';
import 'AddTask.dart';

class CompleteTasksScreen extends StatelessWidget {
   CompleteTasksScreen ({Key? key}) : super(key: key);
   bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;

    return  BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return MyTaskFullWidget(
        height: mediaQuery.height/8,
        list: AppCubit.get(context).completeTasks,
        addTask: true,
        buttonHeight: mediaQuery.height/16,
        isChecked: isChecked);

    //   Column(
    //   children: [
    //     Expanded(
    //       child: ConditionalBuilder(
    //         builder:(context)=>ListView.separated(
    //             shrinkWrap: true,
    //             itemBuilder:(context,index)=>  Padding(
    //               padding: const EdgeInsets.all(20.0),
    //               child: TasksWidget(
    //                   model:AppCubit.get(context).completeTasks[index] ,
    //                   height: mediaQuery.height/8,
    //                   isChecked: isChecked,
    //                   popUpMenuColor: Colors.white,
    //                   checkBorderColor: Colors.white,
    //                   taskName: AppCubit.get(context).completeTasks[index]['title'],
    //                   taskColor: Colors.red,
    //                   onChanged: (value){},
    //                   taskTitleColor: Colors.black,
    //                   checkBoxFillColor: Colors.white
    //                   , checkColor: Colors.red),
    //             ),
    //             separatorBuilder: (context,index)=>const MyDivider(),
    //             itemCount: AppCubit.get(context).completeTasks.length),
    //         fallback:(context)=>Center(
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children:const  [
    //                  Spacer(),
    //                  Icon(Icons.menu,
    //                   size: 100,
    //                   color: Colors.grey,
    //                 ),
    //                  Text(
    //                   'No Tasks Yet Please add Some Tasks',
    //                   style:TextStyle(
    //                       fontSize:16,
    //                       fontWeight: FontWeight.bold) ,),
    //                  Spacer(),
    //               ],
    //             ),
    //           ),
    //         ) ,
    //         condition:AppCubit.get(context).completeTasks.isNotEmpty ,
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: MyElevatedButton(
    //           radius: 6,
    //           borderWidth: 1,
    //           textColor: Colors.white,
    //           fontSize: 16,
    //           borderColor: Colors.green,
    //           height: mediaQuery.height/16,
    //           width: double.infinity,
    //           onTap: (){navigateTo(context, widget:  AddTaskScreen());},
    //           buttonName: 'Add task',
    //           buttonColor: Colors.green),
    //     )
    //
    //   ],
    // );
  },
);
  }
}
