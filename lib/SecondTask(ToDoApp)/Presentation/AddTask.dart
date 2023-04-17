import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/ElevatedButton.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/TextFormField.dart';

import '../Shared/AppCubit/Notifications.dart';
import '../Shared/AppCubit/app_cubit.dart';
import '../Shared/Componets/Componets.dart';
import '../Widget/DropDownMenu.dart';
import 'Board.dart';
import 'Schedule.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final LocalNotificationService service;

  Color textColor = Colors.white;
  String? reminder;

  int? endTimeHours;
  String? remainingEndTimeFormat;
  String? remainingStartTimeFormat;
  int? endTimeMinutes;
  int? finalTotalMinutesInEndTime;
  int? finalTotalMinutesInStartTime;
  int? differentDays;

  // bool? isTheSameDay;
  int? differentMinutes;
  int totalMinutesPerDay = 1440;
  int? differentHours;

  // int? totalMinutesInDeadlineDate;
  DateTime? endDateTime;
  DateTime? startDateTime;
  DateTime? finalEndDateTime;
  DateTime? finalStartDateTime;

  //new

  int? remainingDaysInEndTime;
  int? remainingHoursInEndTime;
  int? remainingMinutesInEndTime;
  int? remainingSecondsInEndTime;

  int? remainingDaysInStartTime;
  int? remainingHoursInStartTime;
  int? remainingMinutesInStartTime;
  int? remainingSecondsInStartTime;

  bool endDateTimeIsOpen = false;
  bool startDateTimeIsOpen = false;
  Duration? differentTimeDuration;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotifications();
    // service.pendingNotification();
    // notifications.intializationNotification();
    super.initState();
  }

  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  var endDateController = TextEditingController();
  var startDateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List reminderList = [
    '1 day before',
    '1 hour before',
    '30 min before',
    '10 min before',
    'none',
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mediaQuery.height / 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        title: const Text('Add task'),
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                    value = titleController.text;
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Details',
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
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mediaQuery.width / 2.5,
                            child: MyTextFormField(
                              labelColor: Colors.white,
                              onChanged: (value) async {},
                              enable: true,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2100-12-01'),
                                ).then((value) async {
                                  setState(() {
                                    startDateTimeIsOpen = true;
                                  });
                                  finalStartDateTime = DateTime(
                                    value!.year,
                                    value.month,
                                    value.day,
                                  );
                                  debugPrint(DateFormat.yMMMd()
                                      .format(DateTime.now()));
                                  // differentTimeDuration= finalDeadlineDateTime!.difference(DateTime.now());
                                  remainingDaysInStartTime = finalStartDateTime!
                                      .difference(DateTime.now())
                                      .inDays;
                                  // print(remainingDaysInEndTime.toString()+'remaining days');
                                  startDateController.text =
                                      DateFormat.yMMMd().format(value);
                                  startDateTime = value;

                                  if (DateFormat.yMMMd()
                                          .format(DateTime.now()) ==
                                      startDateController.text) {
                                    // showToast(
                                    //     text:
                                    //         'The task will start in : $remainingDaysInStartTime Days \n       Task will Start Today',
                                    //     state: ToastState.Warning);
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'The task will start in : $remainingDaysInStartTime Days'
                                          'Task will Start Today'),
                                      backgroundColor: Colors.amber,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    // showToast(
                                    //     text: 'The task will start in: $remainingDaysInStartTime Days ',
                                    //     state: ToastState.Success);
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'The task will start in : $remainingDaysInStartTime Days'),
                                      backgroundColor: Colors.green,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                              hint: DateFormat.yMMMd()
                                  .format(DateTime.now())
                                  .toString(),
                              suffix: Icons.calendar_today,
                              suffixIconColor: Colors.grey[400],
                              control: startDateController,
                              textColor:
                                  Theme.of(context).textTheme.subtitle1!.color!,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color,
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
                                  setState(() {
                                    endDateTimeIsOpen = true;
                                  });
                                  finalEndDateTime = DateTime(
                                    value!.year,
                                    value.month,
                                    value.day,
                                  );
                                  debugPrint(DateFormat.yMMMd()
                                      .format(DateTime.now()));
                                  // differentTimeDuration= finalDeadlineDateTime!.difference(DateTime.now());
                                  remainingDaysInEndTime = finalEndDateTime!
                                      .difference(DateTime.now())
                                      .inDays;
                                  debugPrint(remainingDaysInEndTime.toString() +
                                      'remaining days');
                                  endDateController.text =
                                      DateFormat.yMMMd().format(value);
                                  // await AppCubit.get(context).daysBetween(DateTime.now(), value);
                                  // differentDays = AppCubit.get(context).differenceDaysMinutes;
                                  // print('${differentDays}deadLineeeeeeeeeee');
                                  // totalMinutesInDeadlineDate = (differentDays! * totalMinutesPerDay);
                                  // // finalTotalMinutes=totalMinutesInDeadlineDate;
                                  // // debugPrint('$finalTotalMinutes  Total Minutes in DeadLine ');
                                  endDateTime = value;
                                  // print(deadlineDateTime!.day);
                                  if (DateFormat.yMMMd()
                                          .format(DateTime.now()) ==
                                      endDateController.text) {
                                    // showToast(
                                    //     text:
                                    //         'The Remaining Days is : $remainingDaysInEndTime Days \n       Task Must Finish Today',
                                    //     state: ToastState.Warning);
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'The task will End in : $remainingDaysInEndTime Days '
                                          'it must finish Today'),
                                      backgroundColor: Colors.amber,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    // showToast(
                                    //     text: 'The Remaining Days is: $remainingDaysInEndTime Days ',
                                    //     state: ToastState.Success);
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'This task will End in : $remainingDaysInEndTime Days '),
                                      backgroundColor: Colors.green,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                              hint: DateFormat.yMMMd()
                                  .format(DateTime.now())
                                  .toString(),
                              suffix: Icons.calendar_today,
                              suffixIconColor: Colors.grey[400],
                              control: endDateController,
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
                  height: 20,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color,
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
                                  startTimeController.text =
                                      value!.format(context).toString();
                                  finalStartDateTime = DateTime(
                                      startDateTime!.year,
                                      startDateTime!.month,
                                      startDateTime!.day,
                                      value.hour,
                                      value.minute);
                                  remainingHoursInStartTime =
                                      finalStartDateTime!
                                          .difference(DateTime.now())
                                          .inHours;
                                  remainingMinutesInStartTime =
                                      finalStartDateTime!
                                          .difference(DateTime.now())
                                          .inMinutes;
                                  remainingSecondsInStartTime =
                                      finalStartDateTime!
                                          .difference(DateTime.now())
                                          .inSeconds;
                                  finalTotalMinutesInStartTime =
                                      remainingMinutesInStartTime! +
                                          (remainingHoursInStartTime! * 60) +
                                          (remainingDaysInStartTime! *
                                              totalMinutesPerDay);
                                  String timeConvert(int time) {
                                    remainingStartTimeFormat = ((time / 24 / 60)
                                                    .toInt()
                                                    .toString() +
                                                "d:" +
                                                ((time / 60 % 24)
                                                        .toInt()
                                                        .round())
                                                    .toString() +
                                                'h:' +
                                                (time % 60.toInt()).toString())
                                            .toString() +
                                        ' m';
                                    return ((time / 24 / 60)
                                                    .toInt()
                                                    .toString() +
                                                " d: " +
                                                ((time / 60 % 24)
                                                        .toInt()
                                                        .round())
                                                    .toString() +
                                                'h:' +
                                                (time % 60.toInt()).toString())
                                            .toString() +
                                        'm';
                                  }

                                  debugPrint(timeConvert(
                                      remainingMinutesInStartTime!));

                                  // print(finalStartDateTime!.isBefore(DateTime.now()));
                                  // debugPrint(value.format(context));
                                  if (finalStartDateTime!
                                          .isBefore(DateTime.now()) ==
                                      true) {
                                    var snackBar = SnackBar(
                                      content:
                                          Text('This task is Already started '),
                                      backgroundColor: Colors.amber,
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (!finalStartDateTime!
                                          .isBefore(finalEndDateTime!) &&
                                      !endTimeController.text.isEmpty) {
                                    var snackBar = SnackBar(
                                      content:
                                          Text('Start time is After End Time'),
                                      backgroundColor: Colors.red,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'This task will start in : $remainingStartTimeFormat '),
                                      backgroundColor: Colors.green,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }).catchError((error) {
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Start Time Can't be Empty";
                                } else if (!finalStartDateTime!
                                    .isBefore(finalEndDateTime!)) {
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
                              suffixIconColor:
                                  Theme.of(context).textTheme.subtitle1!.color!,
                              control: startTimeController,
                              textColor:
                                  Theme.of(context).textTheme.subtitle1!.color!,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color,
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
                              enable: endDateTimeIsOpen,
                              suffixClicked: () {},
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  finalEndDateTime = DateTime(
                                    endDateTime!.year,
                                    endDateTime!.month,
                                    endDateTime!.day,
                                    value!.hour,
                                    value.minute,
                                  );
                                  // print(finalDeadlineDateTime!.minute.toString()+' final new');
                                  // print(finalDeadlineDateTime!.difference(DateTime.now()).inSeconds.toString()+' final new');
                                  remainingMinutesInEndTime = finalEndDateTime!
                                      .difference(DateTime.now())
                                      .inMinutes;
                                  remainingHoursInEndTime = finalEndDateTime!
                                      .difference(DateTime.now())
                                      .inHours;
                                  remainingSecondsInEndTime = finalEndDateTime!
                                      .difference(DateTime.now())
                                      .inSeconds;
                                  // print(remainingDaysInEndTime.toString()+' days');
                                  // print(remainingMinutesInEndTime.toString()+' minutes');
                                  // print(remainingHoursInEndTime.toString()+' hours');
                                  endTimeController.text =
                                      value.format(context).toString();

                                  endTimeHours = value.hour;
                                  endTimeMinutes = value.minute;
                                  // finalTotalMinutesInEndTime = remainingMinutesInEndTime!+(remainingHoursInEndTime!*60)+(remainingDaysInEndTime!*totalMinutesPerDay);
                                  // debugPrint(finalTotalMinutesInEndTime.toString()+' final is final minutes AFter All');

                                  String timeConvert(int time) {
                                    remainingEndTimeFormat = ((time / 24 / 60)
                                                    .toInt()
                                                    .toString() +
                                                "d:" +
                                                ((time / 60 % 24)
                                                        .toInt()
                                                        .round())
                                                    .toString() +
                                                'h:' +
                                                (time % 60.toInt()).toString())
                                            .toString() +
                                        ' m';
                                    return ((time / 24 / 60)
                                                    .toInt()
                                                    .toString() +
                                                " d: " +
                                                ((time / 60 % 24)
                                                        .toInt()
                                                        .round())
                                                    .toString() +
                                                'h:' +
                                                (time % 60.toInt()).toString())
                                            .toString() +
                                        'm';
                                  }

                                  debugPrint(
                                      timeConvert(remainingMinutesInEndTime!));

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
                                      var snackBar = SnackBar(
                                        content: Text(
                                            'This task is Already Ended invalid End Time '),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      // showToast(
                                      //     text:
                                      //         '   ${remainingDaysInEndTime!.toInt()} Days  \n  ${remainingHoursInEndTime!.toInt()} Hours \n'
                                      //         ' Invalid Time',
                                      //     state: ToastState.Error);
                                    } else {
                                      // showToast(
                                      //     text: '${remainingDaysInEndTime!.round()} Days '
                                      //         ' \n  ${remainingHoursInEndTime!.toInt()} Hours \n'
                                      //         ' $remainingMinutesInEndTime Total Minutes To Finish The Task ',
                                      //     state: ToastState.Success);
                                      var snackBar = SnackBar(
                                        content: Text(
                                            'The task will End in : $remainingEndTimeFormat  '),
                                        backgroundColor: Colors.green,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } else {
                                    // showToast(
                                    //     text:
                                    //         '${differentDays!.round()} Days \n ${differentHours!.toInt().round()} Hours \n'
                                    //         '$finalTotalMinutes Total Minutes',
                                    //     state: ToastState.Success);
                                    var snackBar = SnackBar(
                                      content: Text(
                                          'The task will End in : $remainingEndTimeFormat  '),
                                      backgroundColor: Colors.green,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }).catchError((error) {
                                  FocusScope.of(context).unfocus();
                                });
                                ;
                              },
                              validator: (value) {
                                debugPrint(
                                    remainingMinutesInEndTime.toString());
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
                      } else if (value == '1 day before' &&
                          remainingMinutesInEndTime! < 1440) {
                        return 'invalid Reminder  $remainingDaysInEndTime Days ';
                      } else if (value == '1 hour before' &&
                          remainingMinutesInEndTime! < 60) {
                        return 'invalid Reminder $remainingHoursInEndTime Hours';
                      } else if (value == '30 min before' &&
                          remainingMinutesInEndTime! < 30) {
                        return 'invalid Reminder $remainingMinutesInEndTime Minutes';
                      } else if (value == '10 min before' &&
                          remainingMinutesInEndTime! < 10) {
                        return 'invalid Reminder $remainingMinutesInEndTime Minutes';
                      } else {
                        reminder = value;
                        if (reminder == '30 min before') {
                          remainingMinutesInEndTime =
                              remainingMinutesInEndTime! - 30;
                          debugPrint(
                              '$remainingMinutesInEndTime   30 minuttttttttttttttttes reminder');
                          finalEndDateTime = DateTime(
                            endDateTime!.year,
                            endDateTime!.month,
                            endDateTime!.day,
                            endTimeHours!,
                            endTimeMinutes! - 30,
                          );
                        } else if (reminder == '1 hour before') {
                          remainingHoursInEndTime =
                              remainingHoursInEndTime! - 1;
                          debugPrint(
                              '$remainingHoursInEndTime   1 hourrrrrrrrrrrrrs reminder');
                          finalEndDateTime = DateTime(
                            endDateTime!.year,
                            endDateTime!.month,
                            endDateTime!.day,
                            endTimeHours! - 1,
                            endTimeMinutes!,
                          );
                        } else if (reminder == '1 day before') {
                          remainingDaysInEndTime = remainingDaysInEndTime! - 1;
                          debugPrint(
                              '$remainingDaysInEndTime   1 daaaaaaaaaaay reminder');
                          finalEndDateTime = DateTime(
                            endDateTime!.year,
                            endDateTime!.month,
                            endDateTime!.day - 1,
                            endTimeHours!,
                            endTimeMinutes!,
                          );
                        } else if (reminder == '10 min before') {
                          remainingMinutesInEndTime =
                              remainingMinutesInEndTime! - 10;
                          debugPrint(
                              '$remainingMinutesInEndTime   10 minuttttttttttes reminder');
                          finalEndDateTime = DateTime(
                            endDateTime!.year,
                            endDateTime!.month,
                            endDateTime!.day,
                            endTimeHours!,
                            endTimeMinutes! - 10,
                          );

                          debugPrint(finalEndDateTime.toString());
                        } else if (reminder == 'none') {
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
                  height: mediaQuery.height / 14,
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
                        finalTotalMinutesInEndTime =
                            remainingMinutesInEndTime! +
                                (remainingHoursInEndTime! * 60) +
                                (remainingDaysInEndTime! * totalMinutesPerDay);
                        debugPrint(finalTotalMinutesInEndTime.toString() +
                            ' final is final minutes After All');

                        String timeConvert(int time) {
                          remainingEndTimeFormat =
                              ((time / 24 / 60).toInt().toString() +
                                          "d:" +
                                          ((time / 60 % 24).toInt().round())
                                              .toString() +
                                          'h:' +
                                          (time % 60.toInt()).toString())
                                      .toString() +
                                  ' m';
                          return ((time / 24 / 60).toInt().toString() +
                                      " d: " +
                                      ((time / 60 % 24).toInt().round())
                                          .toString() +
                                      'h:' +
                                      (time % 60.toInt()).toString())
                                  .toString() +
                              'm';
                        }

                        debugPrint(timeConvert(finalTotalMinutesInEndTime!));

                        await AppCubit.get(context).insertToDataBase(
                          title: titleController.text,
                          endDate: endDateController.text,
                          StartDate: startDateController.text,
                          endTime: endTimeController.text,
                          startTime: startTimeController.text,
                          reminder: reminder!,
                          body: bodyController.text,
                          remainingDays: remainingDaysInEndTime!,
                          remainingHours: remainingHoursInEndTime!,
                          remainingMinutes: remainingMinutesInEndTime!,
                        );
                        debugPrint('${finalTotalMinutesInEndTime}Total Minutes parsed to notification');


                        debugPrint(finalEndDateTime.toString());
                        debugPrint(finalStartDateTime.toString());

                        if (finalStartDateTime!.isBefore(DateTime.now()) ==
                            true) {
                          await service.showNotifications(
                              title: 'New Task Has been Added',
                              body: titleController.text,
                              payload: reminder!,
                              id: AppCubit.get(context).taskId ?? 1);
                        } else {
                          await service.showNotifications(
                              title: 'New Task Has been Added',
                              body: titleController.text,
                              payload: reminder!,
                              id: AppCubit.get(context).taskId ?? 1);

                          await service.showScheduledNotificationsWithStartDate(
                            title:
                                ' Task ${titleController.text} Has been Started',
                            body: bodyController.text,
                            id: AppCubit.get(context).taskId ?? 1,
                            payLoad: finalStartDateTime!.second.toString(),
                            dateTime: finalStartDateTime!,
                          );
                        }
                        await service.showScheduledNotificationsWithEndDate(
                          title: 'Task ${titleController.text} Has been Finished',
                          body: bodyController.text,
                          id: AppCubit.get(context).taskId ?? 1,
                          payLoad: finalEndDateTime!.second.toString(),
                          dateTime: finalEndDateTime!,
                        );

                        showToast(
                            text: '$remainingEndTimeFormat ',
                            state: ToastState.Success);
                        navigateAndFinish(context, const BoardScreen());
                      }
                    },
                    buttonName: 'Create task',
                    buttonColor: Colors.green)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotifications() =>
      service.onNotificationClick.listen(onNotificationsListener);

  void onNotificationsListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      debugPrint("payLoad   $payload");
      navigateTo(context, widget: ScheduleScreen());
    }
  }
}
