
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
        //   Column(
        //   children: [
        //     Expanded(
        //       child: ConditionalBuilder(
        //         builder:(context)=> ListView.separated(
        //           shrinkWrap: true,
        //             itemBuilder:(context,index){
        //             if(AppCubit.get(context).allTasks[index]['status']=='complete'){
        //               taskColor=Colors.green;
        //             }
        //             else if(AppCubit.get(context).allTasks[index]['status']=='unComplete'){
        //               taskColor=Colors.red;
        //             }
        //             else if  (AppCubit.get(context).allTasks[index]['status']=='favourite'){
        //               taskColor=Colors.amber;
        //             }
        //               return  Padding(
        //               padding: const EdgeInsets.all(20.0),
        //               child: TasksWidget(
        //                   model:AppCubit.get(context).allTasks[index] ,
        //                   height: mediaQuery.height/8,
        //                   isChecked: AppCubit.get(context).allTasks[index]['status']=='complete'?true:false,
        //                   popUpMenuColor: Colors.white,
        //                   taskTitleColor: Colors.white,
        //                   checkBorderColor: Colors.white,
        //                   taskName: AppCubit.get(context).allTasks[index]['title'],
        //                   taskColor: taskColor!,
        //                   onChanged: (value){
        //                     // if(AppCubit.get(context).allTasks[index]['status']=='complete'){
        //                     //
        //                     // }
        //                     // if(value==tr)
        //                     // isChecked=!isChecked;
        //                     // value=!value;
        //                     isChecked=true;
        //                     if(value==true) {
        //                       AppCubit.get(context).updateData(status: 'complete', id: AppCubit.get(context).allTasks[index]['id'] );
        //                     }else{
        //                       AppCubit.get(context).updateData(status: 'unComplete', id: AppCubit.get(context).allTasks[index]['id'] );
        //
        //                     }
        //                     // AppCubit.get(context).changeCheckBox(value);
        //                   },
        //                   checkBoxFillColor: Colors.white
        //                   , checkColor: Colors.black),
        //             );},
        //             separatorBuilder: (context,index)=>const MyDivider(),
        //             itemCount: AppCubit.get(context).allTasks.length),
        //        fallback:(context)=>Center(
        //          child: Column(
        //            mainAxisAlignment: MainAxisAlignment.center,
        //            children:  const [
        //              Spacer(),
        //              Icon(Icons.menu,
        //                size: 100,
        //                color: Colors.grey,
        //              ),
        //              Text(
        //                'No Tasks Yet Please add Some Tasks',
        //                style:TextStyle(
        //                    fontSize:16,
        //                    fontWeight: FontWeight.bold) ,),
        //            ],
        //          ),
        //        ) ,
        //        condition:AppCubit.get(context).allTasks.isNotEmpty ,
        //       ),
        //     ),
        //
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
        //   ],
        // );
      },
    );
  }
}
