import 'package:flutter/material.dart';
void navigateTo(context, {required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

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