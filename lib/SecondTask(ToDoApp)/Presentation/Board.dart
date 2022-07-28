
import 'package:algorizainternship/FirstTask(OnBoardingLogin,Register)/Componets/Componets.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/AllTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/CompeleteTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/FavouriteTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/UncompleteTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/Divider.dart';
import 'package:flutter/material.dart';

import '../Shared/AppCubit/Notifications.dart';
import 'Schedule.dart';

class BoardScreen extends StatefulWidget {
   const BoardScreen({Key? key}) : super(key: key);
  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
  return  DefaultTabController(
    length: 4,
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold
        ),
        elevation: 0.5,
        toolbarHeight: mediaQuery.height/7,
        title: Row(
          children:  [
            const Text('Board'),
            const Spacer(),
            IconButton(onPressed: (){
            navigateTo(context, widget:  ScheduleScreen());
            }, icon:const Icon(Icons.calendar_today_outlined,color: Colors.black,) )
          ],
        ),
        bottom:  PreferredSize(
          preferredSize:Size.zero,
          child: Column(
            children:  const [
             MyDivider(),
               SizedBox(
                 width: double.infinity,
                 child: TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                   fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  indicatorColor: Colors.black,
                  physics:BouncingScrollPhysics(),
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 2,
                  indicatorSize:TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text:'All' ),
                    Tab(text:'Completed'),
                    Tab(text:'uncompleted' ),
                    Tab(text: 'Favourite',),

                  ],
              ),
               ),
            ],
          ) ,

        ),
      ),
       body:  TabBarView(
         // controller:tabController ,
         children: [
           AllTasksScreen(),
            CompleteTasksScreen(),
            UnCompleteTasksScreen(),
             FavouriteTasksScreen(),
         ],
       )
    ),
  );
  }
}
