

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/Componets.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/ElevatedButton.dart';

import '../Shared/AppCubit/app_cubit.dart';
import 'EditTask.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Map detailsModel;
  Color taskColor ;

  TaskDetailsScreen({Key? key,required this.detailsModel,
    required this.taskColor}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  int? totalMinutes;

  int? totalSeconds;

  bool reminderFinish=false;

  int totalMinutesPerDay = 1440;

  @override
  Widget build(BuildContext context) {
    var format = DateFormat("HH:mm a");
    // var one = format.parse(TimeOfDay.now().format(context));
    // var two = format.parse(widget.detailsModel['endTime']);
    // print(two.toString()+"two");
    DateTime? dateTime;
    // totalMinutes=two.difference(one).inMinutes;
    // totalSeconds=two.difference(one).inSeconds;
    if (kDebugMode) {
      // print('$totalMinutes Total minutes clockTime');
      // print('$totalSeconds Total Second clockTime');
    }

    //different in dateTime
    // int differnceDays = widget.detailsModel['remainingDays'];
    DateFormat formatDate = DateFormat("yMMMd");
    DateFormat finalFormatDate = DateFormat("yMMd HH:mm a");
    // AppCubit.get(context).daysBetween(DateTime.now(),formatDate.parse(widget.detailsModel['endDate']) );
    // differnceDays=AppCubit.get(context).differenceDaysMinutes!.toInt();
    // var totalDayToMinutes=totalMinutesPerDay*differnceDays;
    // totalMinutes=totalMinutes!+totalDayToMinutes;
    // totalSeconds=totalSeconds!+AppCubit.get(context).differenceDaysSeconds!;
    if (kDebugMode) {
      // print('$totalMinutes Total Minutes After All');
      // print('$totalSeconds Total Seconds After All');
    }
    dateTime=DateTime(
      formatDate.parse(widget.detailsModel['endDate']).year,
      formatDate.parse(widget.detailsModel['endDate']).month,
      formatDate.parse(widget.detailsModel['endDate']).day,
      format.parse(widget.detailsModel['endTime']).hour,
      format.parse(widget.detailsModel['endTime']).minute,
    );
    // finalFormatDate=dateTime;


    debugPrint(dateTime.toString()+' dateTime');
    debugPrint(DateTime.now().toString()+' Now Time');
    debugPrint(DateFormat.jm().format(DateTime.now())+' Now Time 2');
    // print(dateTime.difference(DateTime.now()).inHours);
    totalSeconds=dateTime.difference(DateTime.now().toLocal()).inSeconds;
    // totalSeconds=dateTime.difference(formatDate.parse(DateTime.now().toString())).inSeconds;
    // totalSeconds=dateTime.difference(DateTime.parse(format.format(DateTime.now()))).inSeconds;

    // if(widget.detailsModel['reminder']=='none'){
    //   totalSeconds=dateTime.difference(DateTime.now()).inSeconds;
    //
    // }
    // else if(widget.detailsModel['reminder']=='1 day before'){
    //   totalSeconds=dateTime.difference(DateTime.now()).inSeconds-86400;
    //
    // }
    // if(widget.detailsModel['reminder']=='1 hour before'){
    //   totalSeconds=dateTime.difference(DateTime.now()).inSeconds-3600;
    //
    // }
    // if(widget.detailsModel['reminder']=='30 min before'){
    //   totalSeconds=dateTime.difference(DateTime.now()).inSeconds-1800;
    //
    // }
    //
    // if(widget.detailsModel['reminder']=='10 min before'){
    //   totalSeconds=dateTime.difference(DateTime.now()).inSeconds-600;
    //
    // }

    debugPrint(totalSeconds.toString()+'total minuts');

    var mediaQuery=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0.0,
      toolbarHeight: mediaQuery.height/10,
      title:  const Text('Task Details'),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {Navigator.pop(context);  },
        ),
    ),
    body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,height: mediaQuery.height/2,
          decoration: BoxDecoration(
            color: widget.taskColor,
            borderRadius:BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10,left: 10, right: 10,top: 20),
            child: Column  (
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer,color: Colors.white,size: 20),
                    const SizedBox(width: 5,),
                    Text('${widget.detailsModel['startTime']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),),
                    const Spacer(),
                    Text('${widget.detailsModel['endTime']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),),
                    const SizedBox(width: 5,),
                    const Icon(Icons.timer,color: Colors.white,size: 20,),

                    // const SizedBox(width: 5,),
                    // const Icon(Icons.calendar_today,color:Colors.white),
                    // const SizedBox(width: 5,),
                    // Text('${widget.detailsModel['endDate']}',
                    //   style: const TextStyle(
                    //     color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold ,),),
                    // const SizedBox(width: 5,),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.white,size: 20,),
                    const SizedBox(width: 5,),
                    Text('${widget.detailsModel['startDate']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),),
                    const Spacer(),
                    Text('${widget.detailsModel['endDate']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),),
                    const SizedBox(width: 5,),
                    const Icon(Icons.calendar_today,color: Colors.white,size: 20,),

                    // const SizedBox(width: 5,),
                    // const Icon(Icons.calendar_today,color:Colors.white),
                    // const SizedBox(width: 5,),
                    // Text('${widget.detailsModel['endDate']}',
                    //   style: const TextStyle(
                    //     color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold ,),),
                    // const SizedBox(width: 5,),
                  ],
                ),
                const SizedBox(height: 20,),
                Text('${widget.detailsModel['title']}',
                  style: const TextStyle(
                    color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold ,),),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text('${widget.detailsModel['body']}',maxLines: 6,
                        style: const TextStyle(
                          color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,overflow: TextOverflow.ellipsis),),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
               Spacer(),
               totalSeconds!<0?  Row(
                 children: [
                   Text(' Reminder: ${widget.detailsModel['reminder']}',
                     style: const TextStyle(
                       color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),),
                   Spacer(),
                   Padding(
                       padding:  const EdgeInsets.symmetric(vertical: 14.0),
                       child:widget.detailsModel['status']=='all'?    const Text('UnCompleted Yet',
                         style: TextStyle(
                           color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),):
                       Text('${widget.detailsModel['status']} ',
                         style: const TextStyle(
                           color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold ,),)

                   ),

                 ],
               )
                   : Row(
                     children: [
                       Text('Reminder: ${widget.detailsModel['reminder']}',
                         style: const TextStyle(
                           color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold ,),),
                       Spacer(),
                       Padding(
                           padding:  const EdgeInsets.symmetric(vertical: 20.0),
                           child:widget.detailsModel['status']=='all'?    const Text('UnCompleted Yet',
                             style: TextStyle(
                               color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold ,),):
                           Text('${widget.detailsModel['status']} ',
                             style: const TextStyle(
                               color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold ,),)

                       ),

                     ],
                   ),
                const SizedBox(height: 20,),
               // Visibility(
               //   visible: totalMinutes!>0,
               //   child: Countdown(
               //       seconds: totalSeconds!,
               //       interval: Duration(seconds: 1),
               //       build: (context,double time)=>Text(time.toInt().toString()+'Seconds',
               //         style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
               //     onFinished: (){
               //         setState((){
               //           reminderFinish=true;
               //
               //         });
               //     },
               //   ),
               // ),
                SlideCountdown(duration: Duration(seconds: totalSeconds!,
                ),
                  onDone: (){
                  setState((){
                    totalSeconds==0;
                  });
                  },
                  separatorPadding: EdgeInsets.symmetric( horizontal: 5),
                  decoration: BoxDecoration(color: widget.taskColor),
                  textStyle: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Visibility(
                  visible:totalSeconds!>=0,
                  child: MyElevatedButton(
                    radius: 10,
                    borderWidth: 1,
                    textColor: Colors.white,
                    fontSize: 16,
                    borderColor: widget.detailsModel['status']=="complete"?Colors.red:Colors.green,
                    height: mediaQuery.height/20,
                    width: double.infinity,
                    buttonColor: widget.detailsModel['status']=="complete"?Colors.red:Colors.green,
                    onTap: () {
                      if(totalSeconds!>=0){
                        navigateTo(context, widget: EditTaskScreen( editModel: widget.detailsModel,));

                      }else
                        showToast(text: 'Time is Up ', state: ToastState.Error);

                    },
                    buttonName: 'Edit Task',

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
