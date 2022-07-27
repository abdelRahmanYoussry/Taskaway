// import 'package:algorizainternship/AddToList(Sqflit)/User_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../FirstTask(OnBoardingLogin,Register)/Componets/TextFormField.dart';
// import '../SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
//
// class UserScreen extends StatelessWidget {
//   UserScreen({Key? key}) : super(key: key);
//   var userController = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.teal,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 MyTextFormField(
//                     readOnly: false,
//                     textInputFormat:"[a-zA-Z0-9]",
//                     control: AppCubit.get(context).userController,
//                     type: TextInputType.text,
//                     isPassword: false,
//                     borderColor: Colors.teal,
//                     labelColor: Colors.yellowAccent,
//                     textColor: Colors.black,
//                     onTap: () {},
//                     onChanged: (value){},
//                     suffix: Icons.add,
//                     suffixIconColor: Colors.teal,
//                     suffixClicked: () {
//                       AppCubit.get(context).insertToDataBase();
//                     },
//                     backgroundColor: Colors.white),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Expanded(
//                   child: RefreshIndicator(
//                     color: Colors.teal,
//                     onRefresh: ()async{},
//                     child: ListView.separated(
//                         shrinkWrap: true,
//                         physics: const BouncingScrollPhysics(),
//                         itemBuilder: (context, index) => UserItem(userMap: AppCubit.get(context).userList[index]),
//                         separatorBuilder: (context, index) =>
//                             Container(
//                               width: double.infinity,
//                               height: 1,
//                               color: Colors.grey[300],
//                             ),
//                         itemCount: AppCubit.get(context).userList.length),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
