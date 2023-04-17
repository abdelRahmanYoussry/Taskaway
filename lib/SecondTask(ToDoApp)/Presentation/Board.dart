
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Shared/AppCubit/Notifications.dart';
import '../Shared/AppCubit/app_cubit.dart';
import '../Shared/Componets/Componets.dart';
import '../Widget/Divider.dart';
import 'AllTasks.dart';
import 'CompeleteTasks.dart';
import 'FavouriteTasks.dart';
import 'Schedule.dart';
import 'UncompleteTasks.dart';

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
                const Text('TaskAway',style: TextStyle(color: Colors.green)),
                IconButton(onPressed: (){
                  AppCubit.get(context).changeDarkMode();

                }, icon: AppCubit.get(context).isDark? Icon(Icons.nightlight_round): Icon(Icons.brightness_4_outlined)),
                const Spacer(),
                IconButton(onPressed: (){
                  AppCubit.get(context).getDateToScheduleTable(AppCubit.get(context).database, date: DateFormat.yMMMd().format(DateTime.now()));
                  navigateTo(context, widget:  ScheduleScreen());
                },
                    icon:
                    Icon(Icons.calendar_today_outlined,
                        color:
                        Theme.of(context).textTheme.subtitle1!.color,

                        // Colors.black


                ) )
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
                        color: Colors.blue
                      ),
                      indicatorColor: Theme.of(context).textTheme.subtitle1!.color,
                      physics:const BouncingScrollPhysics(),
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 3,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      indicatorSize:TabBarIndicatorSize.label,
                      tabs: const [
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
