import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/FullTaskWidget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../Widget/Divider.dart';
import '../Widget/TasksWidget.dart';

class ScheduleScreen extends StatelessWidget {
   ScheduleScreen({Key? key}) : super(key: key);
   String scheduleTime=DateFormat.yMMMd().format(DateTime.now()) ;
   String weekScheduleTime=DateFormat('EEEE').format(DateTime.now() );
   @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var cubit=AppCubit.get(context);
    cubit.getDateToScheduleTable(AppCubit.get(context).database, date:scheduleTime );
    bool isChecked = false;
  debugPrint(scheduleTime.toString());
  debugPrint(weekScheduleTime.toString());
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        toolbarHeight: mediaQuery.height/10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {Navigator.pop(context);  },
        ),
        // titleTextStyle: const TextStyle(
        //     color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold
        // ),
        elevation: 0,
        title: const Text('Schedule'),

      ),
      body: Column(
        children: [
         DatePicker(
           DateTime.now(),
           height: mediaQuery.height/9,
           initialSelectedDate: DateTime.now(),
           selectionColor: Colors.green,
           selectedTextColor: Colors.white,
           width: mediaQuery.width/8,
           dayTextStyle:  TextStyle(
             fontSize: 12,color: Theme.of(context).textTheme.subtitle1!.color
           ),
          dateTextStyle:  TextStyle(
              fontSize: 12,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.subtitle1!.color
          ),
           monthTextStyle:TextStyle(
               fontSize: 12,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.subtitle1!.color
           ),
           onDateChange: (date){
              weekScheduleTime=DateFormat('EEEE').format(date);
             cubit.getDateToScheduleTable(AppCubit.get(context).database,date:DateFormat.yMMMd().format(date).toString());

           },
         ),
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: MyDivider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: Row(
              children:  [
                Text(weekScheduleTime,style:  TextStyle(
                  fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.subtitle1!.color
                ),),
                const Spacer(),
                Text(scheduleTime,style:  TextStyle(
                  fontSize: 14,fontWeight: FontWeight.w500,color: Theme.of(context).textTheme.subtitle1!.color
                ),)

              ],
            ),
          ),
         Expanded(
           child: MyTaskFullWidget(
        height: mediaQuery.height/8,
        list: AppCubit.get(context).scheduleTasks,
        buttonHeight: mediaQuery.height/16,
        addTask: false,
        isChecked: isChecked),
         )
        ],
      ),
    );
  },
);
  }
}
