
import 'package:algorizainternship/FirstTask(OnBoardingLogin,Register)/Componets/Componets.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/AllTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/CompeleteTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/FavouriteTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/UncompleteTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/Local/cash_helper.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/Divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/AppCubit/Notifications.dart';
import 'Schedule.dart';

class BoardScreen extends StatelessWidget {
   const BoardScreen({Key? key}) : super(key: key);
  @override
  // State<BoardScreen> createState() => _BoardScreenState();

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0.5,
            toolbarHeight: mediaQuery.height/7,
            title: Row(
              children:  [
                const Text('Taskaway'),
                IconButton(onPressed: (){
                  AppCubit.get(context).changeDarkMode();

                }, icon: AppCubit.get(context).isDark? Icon(Icons.nightlight_round): Icon(Icons.brightness_4_outlined)),
                const Spacer(),
                IconButton(onPressed: (){
                  navigateTo(context, widget:  ScheduleScreen());
                }, icon: Icon(Icons.calendar_today_outlined,color: Theme.of(context).textTheme.subtitle1!.color,) )
              ],
            ),
            bottom:  PreferredSize(
              preferredSize:Size.zero,
              child: Column(
                children:   [
                  const MyDivider(),
                  Container(
                    color: Theme.of(context).backgroundColor,
                    width: double.infinity,
                    child:  TabBar(
                      labelColor: Theme.of(context).textTheme.subtitle1!.color,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      indicatorColor: Theme.of(context).textTheme.subtitle1!.color,
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
      );
  },
),
    );
  }
}

// class _BoardScreenState extends State<BoardScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//   return
//   }
// }
