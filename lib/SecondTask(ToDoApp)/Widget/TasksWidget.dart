import 'package:flutter/material.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/Componets.dart';

import '../Presentation/TaskDetails.dart';
import '../Shared/AppCubit/Notifications.dart';
import '../Shared/AppCubit/app_cubit.dart';

class TasksWidget extends StatefulWidget {
  String taskName;
  bool isChecked;
  bool changeStatus;
  bool showBody;
  bool isFavourite;
  Function onChanged;
  Color checkBoxFillColor;
  Color checkColor;
  Color checkBorderColor;
  Color popUpMenuColor;
  Color taskColor;
  Color taskTitleColor;
  double height;
  Map model;

  TasksWidget({
    Key? key,
    required this.isChecked,
    required this.taskName,
    required this.onChanged,
    required this.changeStatus,
    required this.showBody,
    required this.checkBoxFillColor,
    required this.isFavourite,
    required this.checkColor,
    required this.height,
    required this.checkBorderColor,
    required this.popUpMenuColor,
    required this.taskColor,
    required this.taskTitleColor,
    required this.model,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}
late final LocalNotificationService service;
   @override
  void initState() {
  service = LocalNotificationService();
  service.initialize();
  // service.pendingNotification();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        width: double.infinity,
        height: widget.height,
        padding: const EdgeInsets.only(left: 5.0, right: 5, top: 5),
        decoration: BoxDecoration(
            color: widget.taskColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Row(
                children: [
                  Text(
                    widget.model['endTime'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.model['endDate'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 5,),
            //Row for CheckBox and Title
            Row(
              children: [
                if (widget.changeStatus == true)
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => widget.checkBoxFillColor),
                        checkColor: widget.checkColor,
                        splashRadius: 1,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        side: BorderSide(
                            style: BorderStyle.solid, color: widget.checkBorderColor),
                        value: widget.isChecked,
                        onChanged: (value) {
                          widget.onChanged(value);
                        }),
                  ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: widget.showBody == true
                        ? Center(
                            child: Text(
                              widget.model['title'],
                              style: TextStyle(
                                  color: widget.taskTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          )
                        : Text(
                            widget.model['title'],
                            style: TextStyle(
                                color: widget.taskTitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          )),
                // const Spacer(),
                if (widget.changeStatus == true)
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: MenuItem.item1,
                          child: Container(
                            width: double.infinity,
                            height: mediaQuery.height / 20,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Favourite',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                      PopupMenuItem(
                          value: MenuItem.item2,
                          child: Container(
                            width: double.infinity,
                            height: mediaQuery.height / 20,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Complete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                      PopupMenuItem(
                          value: MenuItem.item3,
                          child: Container(
                            width: double.infinity,
                            height: mediaQuery.height / 20,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Uncomplete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                      PopupMenuItem(
                          value: MenuItem.item4,
                          child: Container(
                            width: double.infinity,
                            height: mediaQuery.height / 20,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color!,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor),
                              ),
                            ),
                          )),
                    ],
                    onSelected: (value) async {
                      if (value == MenuItem.item1) {
                        // debugPrint(MenuItem.item1.toString());
                        AppCubit.get(context).changeStatus(status: 'favourite', id: widget.model['id']);
                      } else if (value == MenuItem.item4) {
                        await  service.deleteEndTimeNotifications(taskId: widget.model['id']);
                        await  service.deleteStartTimeNotifications(taskId: widget.model['id']);
                        AppCubit.get(context).deleteData(id: widget.model['id']);
                      } else if (value == MenuItem.item2) {
                        // taskColor=Colors.green;
                        // taskTitleColor=Colors.white;
                        AppCubit.get(context)
                            .changeStatus(status: 'complete', id: widget.model['id']);
                      } else if (value == MenuItem.item3) {
                        // taskColor=Colors.brown;
                        // taskTitleColor=Colors.white;
                        AppCubit.get(context).changeStatus(
                            status: 'unComplete', id: widget.model['id']);
                      }
                    },
                    color: widget.popUpMenuColor,
                    child: Icon(color: Colors.white, Icons.menu),
                  ),
              ],
            ),
            //body Of the Task
            if (widget.showBody == true)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.model['body'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                ),
              ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.isFavourite == true
                      ? IconButton(
                          onPressed: () {
                            AppCubit.get(context).changeStatus(
                                status: 'unComplete', id: widget.model['id']);
                          },
                          icon: Icon(
                            Icons.star_rate_sharp,
                            color: Colors.amber,
                            size: 30,
                          ))
                      : IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .changeStatus(status: 'favourite', id: widget.model['id']);
                          },
                          icon: Icon(
                            Icons.star_rate_outlined,
                            color: Colors.amber,
                            size: 30,
                          )),
                     Spacer(),
                     // SizedBox.expand(),
                  IconButton(
                    padding: EdgeInsets.only(left: 20),
                      onPressed: () {
                        navigateTo(context,
                            widget: TaskDetailsScreen(
                              detailsModel: widget.model,
                              taskColor: widget.taskColor,
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      onLongPress: () {
        navigateTo(context,
            widget: TaskDetailsScreen(
              detailsModel: widget.model,
              taskColor: widget.taskColor,
            ));
      },
    );
  }
}

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}
