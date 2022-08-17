
import 'package:flutter/material.dart';
import 'package:taskawy/SecondTask(ToDoApp)/Shared/Componets/Componets.dart';

import '../Presentation/TaskDetails.dart';
import '../Shared/AppCubit/app_cubit.dart';

class TasksWidget extends StatelessWidget {
  String taskName;
  bool isChecked;
  bool changeStatus;
  bool showBody;
  Function onChanged;
  Color checkBoxFillColor;
  Color checkColor;
  Color checkBorderColor;
  Color popUpMenuColor;
  Color taskColor;
  Color taskTitleColor;
  double height;
  Map model;
   TasksWidget({Key? key,
 required this.isChecked,
 required this.taskName,
 required this.onChanged,
  required this.changeStatus,
  required this.showBody,
 required this.checkBoxFillColor,
 required this.checkColor,
 required this.height,
 required this.checkBorderColor,
 required this.popUpMenuColor,
 required this.taskColor,
 required this.taskTitleColor,
 required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        width: double.infinity,height: height,
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
        decoration: BoxDecoration(
            color: taskColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
              child: Row(
                children: [
                  Text(
                    model['time'],style: const TextStyle(
                    color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400,),
                  ),
                  const Spacer(),
                  Text(
                    model['date'],style: const TextStyle(
                    color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400,),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 5,),
            //Row for CheckBox and Title
            Row(
              children: [
                if(changeStatus==true)
                Transform.scale(
                  scale: 2,
                  child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith((
                          states) => checkBoxFillColor),
                      checkColor: checkColor,
                      splashRadius: 1,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      side:  BorderSide(
                          style: BorderStyle.solid,color:checkBorderColor
                      ),
                      value: isChecked,
                      onChanged: (value) {
                        onChanged(value);
                      }),
                ),
                 const SizedBox(width: 5,),
                 Expanded(
                   child: showBody==true? Center(
                     child: Text(
                       model['title'],style:  TextStyle(
                         color: taskTitleColor,fontSize: 16,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 1,
                     ),):
                   Text(
                     model['title'],style:  TextStyle(
                       color: taskTitleColor,fontSize: 16,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 2,
                   )
                 ),
                // const Spacer(),
                if(changeStatus==true)
                PopupMenuButton(itemBuilder: (context)=>
                [
                   PopupMenuItem(value:MenuItem.item1, child: Container(
                     width: double.infinity,height:mediaQuery.height/20 ,
                     decoration: BoxDecoration(
                       color: Colors.amber,borderRadius: BorderRadius.circular(10)
                   ), child: const Center(
                       child: Text('Favourite',style:
                        TextStyle(color:Colors.white),),
                     ),
                  ) ),
                   PopupMenuItem(value:MenuItem.item2, child: Container(
                     width: double.infinity,height:mediaQuery.height/20 ,
                     decoration: BoxDecoration(
                       color: Colors.green,borderRadius: BorderRadius.circular(10)
                   ), child: const Center(
                       child: Text('Complete',style:
                        TextStyle(color:Colors.white),),
                     ),
                  ) ),
                   PopupMenuItem(value:MenuItem.item3, child: Container(
                     width: double.infinity,height:mediaQuery.height/20 ,
                     decoration: BoxDecoration(
                       color: Colors.red,borderRadius: BorderRadius.circular(10)
                   ), child: const Center(
                       child: Text('Uncomplete',style:
                        TextStyle(color:Colors.white),),
                     ),
                  ) ),
                  PopupMenuItem(value:MenuItem.item4, child: Container(
                    width: double.infinity,height:mediaQuery.height/20 ,
                    decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.subtitle1!.color!,borderRadius: BorderRadius.circular(10)
                    ), child:  Center(
                    child: Text('Delete',style:
                    TextStyle(color:Theme.of(context).backgroundColor),),
                  ),
                  ) ),
                ],onSelected: (value){
                  if(value==MenuItem.item1){
                    // debugPrint(MenuItem.item1.toString());
                    AppCubit.get(context).changeStatus(status: 'favourite', id: model['id']);
                  }
                  else if(value==MenuItem.item4){
                    AppCubit.get(context).deleteData(id: model['id']);

                  }
                  else if(value==MenuItem.item2){
                    // taskColor=Colors.green;
                    // taskTitleColor=Colors.white;
                    AppCubit.get(context).changeStatus(status: 'complete', id: model['id']);
                  }
                  else if(value==MenuItem.item3){
                    // taskColor=Colors.brown;
                    // taskTitleColor=Colors.white;
                    AppCubit.get(context).changeStatus(status: 'unComplete', id: model['id']);
                  }
                },color:popUpMenuColor ,child: Icon(color: Colors.white,Icons.menu ),
                ),
              ],
            ),
            //body Of the Task
            if(showBody==true)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  model['body'],style: const TextStyle(
                  color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
      onLongPress: (){
          navigateTo(context, widget: TaskDetailsScreen(detailsModel: model,taskColor: taskColor,));
      },
    );

  }

}
 enum MenuItem{
  item1,
  item2,
  item3,
  item4,
}