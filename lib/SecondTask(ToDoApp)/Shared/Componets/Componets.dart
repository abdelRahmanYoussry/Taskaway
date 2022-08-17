import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void navigateTo(context, {required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context,Widget)=>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>Widget),
            (route) => false);


void showToast({
  required String text,
  required ToastState state})=>  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
Color chooseToastColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.Success:
      color=Colors.green;
      break;
    case ToastState.Error:
      color=Colors.red;
      break;
    case ToastState.Warning:
      color=Colors.amber;
      break;
  }
  return color;
}

enum ToastState{Success,Error,Warning}

// Widget tasksEmptyBuilder({required List<Map>tasks})=>ConditionalBuilder(
//     condition:tasks.length>0,
//     builder: (context)=>ListView.separated(
//         itemBuilder: (context,index)=>buildTasksItems(tasks[index],context),
//         separatorBuilder: (context,index)=>dividerWidget(),
//         itemCount:tasks.length),
//     fallback: (context)=>Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [
//           Icon(Icons.menu,
//             size: 100,
//             color: Colors.grey,
//           ),
//           Text(
//             'No Tasks Yet Please add Some Tasks',
//             style:TextStyle(
//                 fontSize:16,
//                 fontWeight: FontWeight.bold) ,)
//         ],
//       ),
//     )
// );