import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../FirstTask(OnBoardingLogin,Register)/Componets/Componets.dart';
import '../../FirstTask(OnBoardingLogin,Register)/Componets/ElevatedButton.dart';
import '../Presentation/AddTask.dart';
import '../Shared/AppCubit/app_cubit.dart';
import 'Divider.dart';
import 'TasksWidget.dart';

class MyTaskFullWidget extends StatelessWidget {
     Color taskColor=Colors.black;
     double height;
     double buttonHeight;
     List <Map>list;
     bool isChecked;
     bool addTask;
     MyTaskFullWidget ({Key? key,
     required this.height,
     required this.list,
     required this.buttonHeight,
     required this.isChecked,
     required this.addTask,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Column(
      children: [
        Expanded(
          child: ConditionalBuilder(
            builder:(context)=> ListView.separated(
                shrinkWrap: true,
                itemBuilder:(context,index){
                  if(list[index]['status']=='complete'){
                    taskColor=Colors.green;
                  }
                  else if(list[index]['status']=='unComplete'||list[index]['status']=='all'){
                    taskColor=Colors.red;
                  }
                  else if  (list[index]['status']=='favourite'){
                    taskColor=Colors.amber;
                  }
                  return  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TasksWidget(
                        model:list[index] ,
                        height: height,
                        isChecked: list[index]['status']=='complete'?true:false,
                        popUpMenuColor: Theme.of(context).backgroundColor,
                        taskTitleColor: Colors.white,
                        checkBorderColor: Colors.white,
                        taskName: list[index]['title'],
                        taskColor: taskColor,
                        onChanged: (value){
                          isChecked=true;
                          if(value==true) {
                            AppCubit.get(context).updateData(status: 'complete', id: list[index]['id'] );
                          }else{
                            AppCubit.get(context).updateData(status: 'unComplete', id: list[index]['id'] );

                          }
                        },
                        checkBoxFillColor: Colors.white
                        , checkColor: Colors.black),
                  );},
                separatorBuilder: (context,index)=>const MyDivider(),
                itemCount: list.length),
            fallback:(context)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:   [
                  Icon(Icons.menu,
                    size: 100,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                   Text(
                    'No Tasks Yet Please add Some Tasks',
                    style:TextStyle(
                        fontSize:16,
                        color:Theme.of(context).textTheme.subtitle1!.color ,
                        fontWeight: FontWeight.bold) ,),
                ],
              ),
            ) ,
            condition:list.isNotEmpty ,
          ),
        ),
          if(addTask==true)
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MyElevatedButton(
              radius: 6,
              borderWidth: 1,
              textColor: Colors.white,
              fontSize: 16,
              borderColor: Colors.green,
              height: buttonHeight,
              width: double.infinity,
              onTap: (){navigateTo(context, widget:  AddTaskScreen());},
              buttonName: 'Add task',
              buttonColor: Colors.green),
        )
      ],
    );

  }
}
