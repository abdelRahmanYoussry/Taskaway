import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/Componets.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/ElevatedButton.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/TextFormField.dart';

import '../Shared/AppCubit/Notifications.dart';
import '../Shared/AppCubit/app_cubit.dart';
import '../Widget/DropDownMenu.dart';
import 'Board.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.editModel}) : super(key: key);
  final Map editModel;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var titleController = TextEditingController();

  var bodyController = TextEditingController();

  var endDateController = TextEditingController();
  var startDateController = TextEditingController();

  var startTimeController = TextEditingController();

  var endTimeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  late final LocalNotificationService service;

  Color textColor = Colors.white;

  String? reminder;

  List reminderList = [
    '1 day before',
    '1 hour before',
    '30 min before',
    '10 min before',
    'None',
  ];

  int? endTimeHours;
  int? endTimeMinutes;
  int? startTimeHours;
  int? startTimeMinutes;
  int? totalMinutes;
  int? editTotalMinutes;
  DateTime? endDateTime;
  DateTime? startDateTime;
  String? remainingEndTimeFormat;
  String? remainingStartTimeFormat;
  int? notificationAfterByHours;
  bool? isTheSameDay;
  int totalMinutesPerDay = 1440;
  //new
  int?remainingDaysInEndTime;
  int?remainingHoursInEndTime;
  int?remainingMinutesInEndTime;
  int?remainingSecondsInEndTime;
  int?remainingDaysInStartTime;
  int?remainingHoursInStartTime;
  int?remainingMinutesInStartTime;
  int?remainingSecondsInStartTime;
  bool endDateTimeIsOpen=false;
  bool startDateTimeIsOpen=false;
  int? finalTotalMinutesInEndTime;
  int? finalTotalMinutesInStartTime;
  int? differentDays;
  int? differentHours;
  DateTime? finalEndDateTime;
  DateTime? finalStartDateTime;
  var format = DateFormat("HH:mm ");
  DateFormat formatDate = DateFormat("yMMMd");

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotifications();
    // notifications.intializationNotification();
    super.initState();
    titleController.text = widget.editModel['title'];
    bodyController.text = widget.editModel['body'];
    endDateController.text = widget.editModel['endDate'];
    startTimeController.text = widget.editModel['startTime'];
    endTimeController.text = widget.editModel['endTime'];
    startDateController.text=widget.editModel['startDate'];
    reminder = widget.editModel['reminder'];
    // var one = format.parse(TimeOfDay.now().format(context));
    // var two = format.parse(endTimeController.text);
    // totalMinutes=two.difference(one).inMinutes;
    if (kDebugMode) {
      // print('$totalMinutes Total miuntes clockTime');
    }
    //different in dateTime
    finalEndDateTime=DateTime(
      formatDate.parse(widget.editModel['endDate']).year,
      formatDate.parse(widget.editModel['endDate']).month,
      formatDate.parse(widget.editModel['endDate']).day,
      format.parse(widget.editModel['endTime']).hour,
      format.parse(widget.editModel['endTime']).minute,
    );
    finalStartDateTime=DateTime(
      formatDate.parse(widget.editModel['startDate']).year,
      formatDate.parse(widget.editModel['startDate']).month,
      formatDate.parse(widget.editModel['startDate']).day,
      format.parse(widget.editModel['startTime']).hour,
      format.parse(widget.editModel['startTime']).minute,
    );
    remainingMinutesInEndTime= finalEndDateTime!.difference(DateTime.now()).inMinutes;
    debugPrint(finalStartDateTime.toString());
    debugPrint(finalEndDateTime.toString());
    remainingDaysInEndTime=finalEndDateTime!.difference(DateTime.now()).inDays;
    remainingHoursInEndTime= finalEndDateTime!.difference(DateTime.now()).inHours;
  }

  Widget build(BuildContext context) {

    //different in end time clock

    // formatDate.parse(widget.editModel['endDate']);

    // AppCubit.get(context).daysBetween(DateTime.now(),formatDate.parse(deadLineController.text) );
    // differnceDays=AppCubit.get(context).differenceDaysMinutes!.toInt();
    // var totalDayToMinutes=totalMinutesPerDay*differnceDays;
    // totalMinutes=totalMinutes!+totalDayToMinutes;
    // if (kDebugMode) {
    //   print('$totalMinutes Total Minutes After All');
    // }
    // AppCubit.get(context).differenceFormattedString(totalMinutes!);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var mediaQuery = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.white,
            toolbarHeight: mediaQuery.height / 10,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            title: const Text('Edit task'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Title',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextFormField(
                      textInputFormat: "[a-z A-Z0-9 ]",
                      labelColor: Colors.white,
                      enable: true,
                      onChanged: (value) {},
                      onTap: () {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Title Can't be Empty";
                        }
                        if (value.toString().length > 20) {
                          return "Title Can't be More than 20 character";
                        }
                        return null;
                      },
                      readOnly: false,
                      onSubmit: (value) {
                        titleController.text=value;
                      },
                      borderColor: Colors.grey[200]!,
                      backgroundColor: Colors.grey[200]!,
                      type: TextInputType.text,
                      hint: 'Task Title',
                      control: titleController,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Note',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextFormField(
                      textInputFormat: "[a-z A-Z0-9 ]",
                      labelColor: Colors.white,
                      enable: true,
                      onChanged: (value) {},
                      onTap: () {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Task Details Can't be Empty";
                        }
                        return null;
                      },
                      readOnly: false,
                      onSubmit: (value) {
                        value = titleController.text;
                      },
                      borderColor: Colors.grey[200]!,
                      backgroundColor: Colors.grey[200]!,
                      type: TextInputType.text,
                      hint: 'Task body',
                      control: bodyController,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Start Date',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.subtitle1!.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width/2.5,
                                child: MyTextFormField(
                                  labelColor: Colors.white,
                                  onChanged: (value) {},
                                  enable: true,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2100-12-01'),
                                    ).then((value) async {
                                      setState((){
                                        startDateTimeIsOpen=true;
                                      });
                                      finalStartDateTime=DateTime(
                                        value!.year,
                                        value.month,
                                        value.day,
                                        format.parse(widget.editModel['startTime']).hour,
                                        format.parse(widget.editModel['startTime']).minute,
                                      );
                                      debugPrint(DateFormat.yMMMd().format(DateTime.now()));
                                      // differentTimeDuration= finalDeadlineDateTime!.difference(DateTime.now());
                                      // remainingDaysInEndTime=finalEndDateTime!.difference(DateTime.now()).inDays;
                                      remainingDaysInStartTime=finalStartDateTime!.difference(DateTime.now()).inDays;
                                      // print(remainingDaysInEndTime.toString()+'remaining days');
                                      startDateController.text = DateFormat.yMMMd().format(value);
                                      startDateTime = value;

                                      if (DateFormat.yMMMd().format(DateTime.now()) ==startDateController.text ) {
                                        // showToast(
                                        //     text:
                                        //         'The task will start in : $remainingDaysInStartTime Days \n       Task will Start Today',
                                        //     state: ToastState.Warning);
                                        var snackBar=SnackBar(content: Text( 'The task will start in : $remainingDaysInStartTime Days'
                                            'Task will Start Today'),
                                          backgroundColor: Colors.amber,

                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                      }
                                      else {
                                        // showToast(
                                        //     text: 'The task will start in: $remainingDaysInStartTime Days ',
                                        //     state: ToastState.Success);
                                        var snackBar=SnackBar(content: Text( 'The task will start in : $remainingDaysInStartTime Days'),
                                          backgroundColor: Colors.green,

                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }

                                    }).catchError((error) {
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Start date Can't be Empty";
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  borderColor: Colors.grey[200]!,
                                  backgroundColor: Colors.grey[200]!,
                                  type: TextInputType.text,
                                  hint: DateFormat.yMMMd().format(DateTime.now()).toString(),
                                  suffix: Icons.calendar_today,
                                  suffixIconColor: Colors.grey[400],
                                  control: startDateController,
                                  textColor: Theme.of(context).textTheme.subtitle1!.color!,
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'End Date',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.subtitle1!.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width,
                                child: MyTextFormField(
                                  labelColor: Colors.white,
                                  onChanged: (value) {},
                                  enable: true,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2100-12-01'),
                                    ).then((value) async {
                                      // if (differentDays == 0) {
                                      //   isTheSameDay = true;
                                      //   debugPrint(isTheSameDay.toString());
                                      // }
                                      setState((){
                                        endDateTimeIsOpen=true;
                                      });
                                      finalEndDateTime=DateTime(
                                        value!.year,
                                        value.month,
                                        value.day,
                                        format.parse(widget.editModel['endTime']).hour,
                                        format.parse(widget.editModel['endTime']).minute,
                                      );
                                      debugPrint(DateFormat.yMMMd().format(DateTime.now()));
                                      // differentTimeDuration= finalDeadlineDateTime!.difference(DateTime.now());
                                      remainingDaysInEndTime=finalEndDateTime!.difference(DateTime.now()).inDays;
                                      debugPrint(remainingDaysInEndTime.toString()+'remaining days');
                                      endDateController.text = DateFormat.yMMMd().format(value);
                                      // await AppCubit.get(context).daysBetween(DateTime.now(), value);
                                      // differentDays = AppCubit.get(context).differenceDaysMinutes;
                                      // print('${differentDays}deadLineeeeeeeeeee');
                                      // totalMinutesInDeadlineDate = (differentDays! * totalMinutesPerDay);
                                      // // finalTotalMinutes=totalMinutesInDeadlineDate;
                                      // // debugPrint('$finalTotalMinutes  Total Minutes in DeadLine ');
                                      endDateTime = value;
                                      // print(deadlineDateTime!.day);
                                      if (DateFormat.yMMMd().format(DateTime.now()) ==endDateController.text ) {
                                        // showToast(
                                        //     text:
                                        //         'The Remaining Days is : $remainingDaysInEndTime Days \n       Task Must Finish Today',
                                        //     state: ToastState.Warning);
                                        var snackBar=SnackBar(content: Text( 'The task will End in : $remainingDaysInEndTime Days '
                                            'it must finish Today'),
                                          backgroundColor: Colors.amber,

                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      } else {
                                        // showToast(
                                        //     text: 'The Remaining Days is: $remainingDaysInEndTime Days ',
                                        //     state: ToastState.Success);
                                        var snackBar=SnackBar(content: Text( 'This task will End in : $remainingDaysInEndTime Days '),
                                          backgroundColor: Colors.green,

                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                      // deadlineTime=value;
                                    }).catchError((error) {
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "End Date Can't be Empty";
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  borderColor: Colors.grey[200]!,
                                  backgroundColor: Colors.grey[200]!,
                                  type: TextInputType.text,
                                  hint: DateFormat.yMMMd().format(DateTime.now()).toString(),
                                  suffix: Icons.calendar_today,
                                  suffixIconColor: Colors.grey[400],
                                  control: endDateController,
                                  textColor: Theme.of(context).textTheme.subtitle1!.color!,
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Start Time',
                                  style: TextStyle(
                                    color:
                                    Theme.of(context).textTheme.subtitle1!.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width / 2.5,
                                child: MyTextFormField(
                                  labelColor: Colors.white,
                                  enable: startDateTimeIsOpen,
                                  onChanged: (value) {},
                                  suffixClicked: () {},
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                        .then((value) {
                                      startTimeController.text = value!.format(context).toString();
                                      finalStartDateTime=DateTime(
                                          startDateTime!.year,
                                          startDateTime!.month,
                                          startDateTime!.day,
                                          value.hour,
                                          value.minute
                                      );
                                      remainingHoursInStartTime=finalStartDateTime!.difference(DateTime.now()).inHours;
                                      remainingMinutesInStartTime=finalStartDateTime!.difference(DateTime.now()).inMinutes;
                                      remainingSecondsInStartTime=finalStartDateTime!.difference(DateTime.now()).inSeconds;
                                      finalTotalMinutesInStartTime=remainingMinutesInStartTime!+(remainingHoursInStartTime!*60)+
                                          (remainingDaysInStartTime!*totalMinutesPerDay);
                                      String  timeConvert(int time) {
                                        remainingStartTimeFormat=((time/24/60 ).toInt().toString()+ "d:"+((time/60%24).toInt().round()).toString()+'h:' +
                                            (time%60.toInt()).toString()).toString()+' m';
                                        return ((time/24/60 ).toInt().toString()+ " d: " + ((time/60%24).toInt().round()).toString() + 'h:' +
                                            (time%60.toInt()).toString()).toString()+'m';
                                      }
                                      debugPrint(timeConvert(remainingMinutesInStartTime!));

                                      // print(finalStartDateTime!.isBefore(DateTime.now()));
                                      // debugPrint(value.format(context));
                                      if(finalStartDateTime!.isBefore(DateTime.now())==true){
                                        var snackBar=SnackBar(content: Text( 'This task is Already started '),
                                          backgroundColor: Colors.amber,
                                        );

                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                      else  if(!finalStartDateTime!.isBefore(finalEndDateTime!)&&!endTimeController.text.isEmpty){
                                        var snackBar=SnackBar(content: Text( 'Start time is After End Time'),
                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                      }
                                      else{
                                        var snackBar=SnackBar(content: Text( 'This task will start in : $remainingStartTimeFormat '),
                                          backgroundColor: Colors.green,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                      }

                                    }).catchError((error) {
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Start Time Can't be Empty";
                                    }
                                    else if(finalStartDateTime!.isAfter(finalEndDateTime!)){
                                      return 'End Time is before Start time';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  borderColor: Colors.grey[200]!,
                                  backgroundColor: Colors.grey[200]!,
                                  type: TextInputType.text,
                                  hint: '11:00 Am',
                                  suffix: Icons.timer,
                                  suffixIconColor: Theme.of(context).textTheme.subtitle1!.color!,
                                  control: startTimeController,
                                  textColor: Theme.of(context).textTheme.subtitle1!.color!,
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'End Time',
                                  style: TextStyle(
                                    color:
                                    Theme.of(context).textTheme.subtitle1!.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width ,
                                child: MyTextFormField(
                                  labelColor: Colors.white,
                                  onChanged: (value) {},
                                  enable: endDateTimeIsOpen ,
                                  suffixClicked: () {},
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                        .then((value) {
                                      finalEndDateTime=DateTime(
                                        endDateTime!.year,
                                        endDateTime!.month,
                                        endDateTime!.day,
                                        value!.hour,
                                        value.minute,
                                      );
                                      // print(finalDeadlineDateTime!.minute.toString()+' final new');
                                      // print(finalDeadlineDateTime!.difference(DateTime.now()).inSeconds.toString()+' final new');
                                      remainingMinutesInEndTime= finalEndDateTime!.difference(DateTime.now()).inMinutes;
                                      remainingHoursInEndTime= finalEndDateTime!.difference(DateTime.now()).inHours;
                                      remainingSecondsInEndTime= finalEndDateTime!.difference(DateTime.now()).inSeconds;
                                      // print(remainingDaysInEndTime.toString()+' days');
                                      // print(remainingMinutesInEndTime.toString()+' minutes');
                                      // print(remainingHoursInEndTime.toString()+' hours');
                                      endTimeController.text = value.format(context).toString();

                                      endTimeHours = value.hour;
                                      endTimeMinutes = value.minute;
                                      // finalTotalMinutesInEndTime = remainingMinutesInEndTime!+(remainingHoursInEndTime!*60)+(remainingDaysInEndTime!*totalMinutesPerDay);
                                      // debugPrint(finalTotalMinutesInEndTime.toString()+' final is final minutes AFter All');

                                      String  timeConvert(int time) {
                                        remainingEndTimeFormat=((time/24/60 ).toInt().toString()+ "d:"+((time/60%24).toInt().round()).toString()+'h:' +
                                            (time%60.toInt()).toString()).toString()+' m';
                                        return ((time/24/60 ).toInt().toString()+ " d: " + ((time/60%24).toInt().round()).toString() + 'h:' +
                                            (time%60.toInt()).toString()).toString()+'m';
                                      }
                                      debugPrint(timeConvert(remainingMinutesInEndTime!));

                                      // debugPrint(endTimeMinutes.toString()+'this is endTimeMinutes');
                                      // var hn = TimeOfDay.now().hour;
                                      // var h = value.hour - hn;
                                      // differentHours = h;
                                      // var mn = TimeOfDay.now().minute;
                                      // var m = value.minute - mn;
                                      // differentMinutes = differentHours! * 60;
                                      // differentMinutes = differentMinutes! + m;
                                      // finalTotalMinutes = totalMinutesInDeadlineDate! + differentMinutes!;
                                      // debugPrint('$differentMinutes  differenceMinutes');
                                      // debugPrint('$finalTotalMinutes  totalMinutes');
                                      // debugPrint('$differentDays  differnceDays');

                                      if (remainingDaysInEndTime == 0) {
                                        if (remainingMinutesInEndTime! <= 0) {
                                          var snackBar=SnackBar(content: Text( 'This task is Already Ended invalid End Time '),
                                            backgroundColor: Colors.red,

                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          // showToast(
                                          //     text:
                                          //         '   ${remainingDaysInEndTime!.toInt()} Days  \n  ${remainingHoursInEndTime!.toInt()} Hours \n'
                                          //         ' Invalid Time',
                                          //     state: ToastState.Error);
                                        }
                                        else {
                                          // showToast(
                                          //     text: '${remainingDaysInEndTime!.round()} Days '
                                          //         ' \n  ${remainingHoursInEndTime!.toInt()} Hours \n'
                                          //         ' $remainingMinutesInEndTime Total Minutes To Finish The Task ',
                                          //     state: ToastState.Success);
                                          var snackBar=SnackBar(content: Text( 'The task will End in : $remainingEndTimeFormat  '),
                                            backgroundColor: Colors.green,

                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      }
                                      else {
                                        // showToast(
                                        //     text:
                                        //         '${differentDays!.round()} Days \n ${differentHours!.toInt().round()} Hours \n'
                                        //         '$finalTotalMinutes Total Minutes',
                                        //     state: ToastState.Success);
                                        var snackBar=SnackBar(content: Text( 'The task will End in : $remainingEndTimeFormat  '),
                                          backgroundColor: Colors.green,);
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    }).catchError((error) {
                                      FocusScope.of(context).unfocus();
                                    });
                                    ;
                                  },
                                  validator: (value) {
                                    debugPrint(remainingMinutesInEndTime.toString());
                                    if (value.isEmpty) {
                                      return "End Time Can't be Empty";
                                    } else if (remainingDaysInEndTime! <= 0) {
                                      if (remainingMinutesInEndTime! <= 0) {
                                        return "Invalid End Time";
                                      }
                                    }

                                    return null;
                                  },
                                  readOnly: true,
                                  borderColor: Colors.grey[200]!,
                                  backgroundColor: Colors.grey[200]!,
                                  type: TextInputType.text,
                                  hint: TimeOfDay.now().format(context).toString(),
                                  control: endTimeController,
                                  suffix: Icons.timer,
                                  suffixIconColor:
                                  Theme.of(context).textTheme.subtitle1!.color,
                                  textColor:
                                  Theme.of(context).textTheme.subtitle1!.color!,
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Reminder',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color!,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyDropDownMenuButton(
                        height: mediaQuery.height / 10,
                        hint: Text(
                          'Remind Me',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .color!
                                .withOpacity(0.3),
                            fontSize: 12,
                          ),
                        ),
                        borderColor: Colors.grey[300]!,
                        validator: (value) {
                          if (value == null) {
                            return "Reminder Can't be Empty";
                          }
                          else if (value == '1 day before' && remainingDaysInEndTime! <= 0) {
                            return 'invalid Reminder  $remainingDaysInEndTime Days ';
                          }
                          else if (value == '1 hour before' && remainingHoursInEndTime! <= 1) {
                            return 'invalid Reminder $remainingHoursInEndTime Minutes';
                          }
                          else if (value == '30 min before' && remainingMinutesInEndTime! <= 30) {
                            return 'invalid Reminder $remainingMinutesInEndTime Minutes';
                          }
                          else if (value == '10 min before' && remainingMinutesInEndTime! <= 10) {
                            return 'invalid Reminder $remainingMinutesInEndTime Minutes';
                          }
                          else {
                            reminder = value;
                            if (reminder == '30 min before') {
                              remainingMinutesInEndTime = remainingMinutesInEndTime! - 30;
                              debugPrint(
                                  '$remainingMinutesInEndTime   30 minuttttttttttttttttes reminder');
                              finalEndDateTime=DateTime(
                                endDateTime!.year,
                                endDateTime!.month,
                                endDateTime!.day,
                                endTimeHours!,
                                endTimeMinutes!-30,
                              );

                            }
                            else if (reminder == '1 hour before') {
                              remainingHoursInEndTime = remainingHoursInEndTime! - 1;
                              debugPrint(
                                  '$remainingHoursInEndTime   1 hourrrrrrrrrrrrrs reminder');
                              finalEndDateTime=DateTime(
                                endDateTime!.year,
                                endDateTime!.month,
                                endDateTime!.day,
                                endTimeHours!-1,
                                endTimeMinutes!,
                              );

                            } else if (reminder == '1 day before') {
                              remainingDaysInEndTime = remainingDaysInEndTime! - 1;
                              debugPrint(
                                  '$remainingDaysInEndTime   1 daaaaaaaaaaay reminder');
                              finalEndDateTime=DateTime(
                                endDateTime!.year,
                                endDateTime!.month,
                                endDateTime!.day-1,
                                endTimeHours!,
                                endTimeMinutes!,
                              );

                            } else if (reminder == '10 min before') {
                              remainingMinutesInEndTime = remainingMinutesInEndTime! - 10;
                              debugPrint(
                                  '$remainingMinutesInEndTime   10 minuttttttttttes reminder');
                              finalEndDateTime=DateTime(
                                endDateTime!.year,
                                endDateTime!.month,
                                endDateTime!.day,
                                endTimeHours!,
                                endTimeMinutes!-10,
                              );

                              debugPrint(finalEndDateTime.toString());

                            }
                            else if(reminder=='none'){
                              // finalTotalMinutes=finalTotalMinutes;
                              debugPrint('$finalTotalMinutesInEndTime   none');
                              debugPrint('$finalEndDateTime   none');
                            }
                            // print('${reminder!} Reminder');
                          }
                        },
                        textColor: textColor,
                        labelColor: Theme.of(context).backgroundColor,
                        onChange: (value) {},
                        myDropDownItems: reminderList.map((e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  Text(
                                    e,
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ));
                        }).toList(),
                        context: context),
                    SizedBox(
                      height: mediaQuery.height / 14.toDouble(),
                    ),
                    MyElevatedButton(
                        radius: 6,
                        borderWidth: 1,
                        textColor: Colors.white,
                        fontSize: 16,
                        borderColor: Colors.green,
                        height: mediaQuery.height / 16,
                        width: double.infinity,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await AppCubit.get(context).updateData(
                                title: titleController.text,
                                body: bodyController.text,
                                startTime: startTimeController.text,
                                endTime: endTimeController.text,
                                reminder: reminder!,
                                endDate: endDateController.text,
                                startDate: startDateController.text,
                                id: widget.editModel['id'],
                                remainingMinutes: remainingMinutesInEndTime!,
                                remainingHours: remainingHoursInEndTime!,
                                remainingDays: remainingDaysInEndTime!);

                            // String  timeConvert(int time) {
                            //   remainingEndTimeFormat=((time/24/60 ).toInt().toString()+ "d:"+((time/60%24).toInt().round()).toString()+'h:' +
                            //       (time%60.toInt()).toString()).toString()+' m';
                            //   return ((time/24/60 ).toInt().toString()+ " d: " + ((time/60%24).toInt().round()).toString() + 'h:' +
                            //       (time%60.toInt()).toString()).toString()+'m';
                            // }
                            // debugPrint(timeConvert(finalTotalMinutesInEndTime!));

                            await service.deleteEndTimeNotifications(
                                taskId: AppCubit.get(context).taskId!);

                            // await service.deleteStartTimeNotifications(
                            //     taskId: widget.editModel['id']);
                            // if (kDebugMode) {
                            //   // print('${totalMinutes}Total Minutes');
                            //   // print('${editTotalMinutes}Total Minutes');
                            // }
                           debugPrint(finalEndDateTime.toString()+'Final End Date Time Laaaaaaaaast');


                            if(finalStartDateTime!.isBefore(DateTime.now())==true){
                              await service.showNotifications(
                                  title: ' Task Has been Edit',
                                  body: titleController.text,
                                  payload: reminder!,
                                  id: AppCubit.get(context).taskId??1);

                            }
                            else{
                              await service.showScheduledNotificationsWithStartDate(
                                title: ' Task Time Has been Started',
                                body:  titleController.text,
                                id: AppCubit.get(context).taskId??1,
                                payLoad: finalEndDateTime!.second.toString(),
                                dateTime: finalStartDateTime!,
                              );
                              await service.showNotifications(
                                  title: 'Task Has been Edit',
                                  body: titleController.text,
                                  payload: reminder!,
                                  id: AppCubit.get(context).taskId??1);

                            }

                            // await service.showScheduledNotificationsWithStartDate(
                            //   title: ' Task Time Has been Started',
                            //   body:  titleController.text,
                            //   id: AppCubit.get(context).taskId,
                            //   payLoad: finalEndDateTime!.second.toString(),
                            //   dateTime: finalStartDateTime!,
                            // );


                            // await service.showNotifications(
                            //     title: titleController.text,
                            //     body: bodyController.text,
                            //     payload: reminder!,
                            //     id: 1);

                            // await service.showScheduledNotifications(
                            //     title: titleController.text,
                            //     body: bodyController.text,
                            //     minutes: editTotalMinutes!,
                            //     id: AppCubit.get(context).taskId
                            //     // AppCubit.get(context).taskId,
                            //     );
                            // await service.showNotificationsWithPayLoad(
                            //     title: titleController.text,
                            //     body: bodyController.text,
                            //     payload: 'This is pay load',
                            //     id: 1
                            //     // AppCubit.get(context).taskId,
                            //     );
                            // showToast(
                            //     text:
                            //         'The Reminder will be After \n $editTotalMinutes Total Minutes ',
                            //     state: ToastState.Success);

                            // showToast(
                            //     text: '$remainingEndTimeFormat ', state: ToastState.Success);
                            await service.showScheduledNotificationsWithEndDate(
                              title: 'Task Time Has been Finished',
                              body:  titleController.text,
                              id: AppCubit.get(context).taskId??1,
                              payLoad: finalEndDateTime!.second.toString(),
                              dateTime: finalEndDateTime!,
                            );

                            navigateAndFinish(context, const BoardScreen());
                          }
                        },
                        buttonName: 'Edit task',
                        buttonColor: Colors.green)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void listenToNotifications() =>
      service.onNotificationClick.listen(onNotificationsListener);

  void onNotificationsListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      debugPrint("payLoad   $payload");
      // navigateTo(context, widget:  ScheduleScreen());
    }
  }
}
