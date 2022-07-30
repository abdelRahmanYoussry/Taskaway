import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/AllTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../FirstTask(OnBoardingLogin,Register)/Componets/ElevatedButton.dart';
import '../Shared/AppCubit/Notifications.dart';
import 'Board.dart';

class AddTaskScreen extends StatefulWidget {
   AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();

}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var notifications= Notications();
  bool x=false;
  Color textColor = Colors.white;
  Color textColor2 = Colors.white;
  void initState() {
    notifications.intializationNotification();
   super.initState();
  }
   var titleController= TextEditingController();
   var deadLineController= TextEditingController();
   var startTimeController= TextEditingController();
   var endTimeController= TextEditingController();
   var reminderController= TextEditingController();
   var repeatController= TextEditingController();
   var formKey=GlobalKey<FormState>();
   List reminderList=[
     '1 day before', '1 hour before', '30 min before', '10 min before',];
   List repeatList=['Daily', 'Weekly'];
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        toolbarHeight: mediaQuery.height/10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {Navigator.pop(context);  },
        ),
        // titleTextStyle: const TextStyle(
        //     color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold
        // ),
        elevation: 0.5,
        title: const Text('Add task'),

      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children:  [
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Title',
                    style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1!.color,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                MyTextFormField(
                  textInputFormat:"[a-z A-Z0-9 ]",
                  labelColor: Colors.white,
                  hintStyle: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.3)
                  ),
                  onChanged: (value){},
                  onTap: (){},
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title Can't be Empty";
                    }
                    return null;
                  },
                  readOnly: false,
                  onSubmit: (value){
                    value=titleController.text;
                  },
                  borderColor: Colors.grey[200]!,
                  backgroundColor: Colors.grey[200]!,
                  type: TextInputType.text,
                  hint: 'Task Title',
                  control: titleController,
                  textColor: Theme.of(context).textTheme.subtitle1!.color!,
                  isPassword: false,),
                const SizedBox(
                  height: 10,
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('DeadLine',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                MyTextFormField(
                  labelColor: Colors.white,
                  onChanged: (value){},
                  hintStyle: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.3)
                  ),
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2025-12-01'),
                    ).then((value) {
                      deadLineController.text = DateFormat.yMMMd().format(value!);
                    });

                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "DeadLine Can't be Empty";
                    }
                    return null;
                  },
                  readOnly: true,
                  borderColor: Colors.grey[200]!,
                  backgroundColor: Colors.grey[200]!,
                  type: TextInputType.text,
                  hint: '2022-07-28',
                  suffix: Icons.arrow_drop_down_sharp,
                  suffixIconColor: Colors.grey[400],
                  control: deadLineController,
                  textColor: Theme.of(context).textTheme.subtitle1!.color!,
                  isPassword: false,),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Start Time',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.subtitle1!.color,fontSize: 18,fontWeight: FontWeight.bold ,),),
                        ),
                        SizedBox(
                          width: mediaQuery.width/2.5,
                          child: MyTextFormField(
                            labelColor: Colors.white,
                            onChanged: (value){},
                            hintStyle: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.3)
                            ),
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                                  .then((value) {
                                startTimeController.text = value!.format(context).toString();

                                debugPrint(value.format(context));
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Start Time Can't be Empty";
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
                            isPassword: false,),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('End Time',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.subtitle1!.color,fontSize: 18,fontWeight: FontWeight.bold ,),),
                        ),
                        SizedBox(
                          width: mediaQuery.width/2.5,
                          child: MyTextFormField(
                            labelColor: Colors.white,
                            onChanged: (value){},
                            hintStyle: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.3)
                            ),
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                                  .then((value) {
                                endTimeController.text = value!.format(context).toString();

                                debugPrint(value.format(context));
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "End Time Can't be Empty";
                              }
                              return null;
                            },
                            readOnly: true,
                            borderColor: Colors.grey[200]!,
                            backgroundColor: Colors.grey[200]!,
                            type: TextInputType.text,
                            hint: '05:00 pm',
                            control: endTimeController,
                            suffix: Icons.timer,
                            suffixIconColor: Theme.of(context).textTheme.subtitle1!.color,
                            textColor: Theme.of(context).textTheme.subtitle1!.color!,
                            isPassword: false,),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Reminder',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color!,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                const SizedBox(
                  height: 10,
                ),
               Container(
            decoration: BoxDecoration(
              color: Colors.grey[200]!,
              borderRadius: BorderRadius.circular(10),
            ),
            height:mediaQuery.height/10 ,
            child: myDropDownMenu(
                hint:  Text('1 hour before',style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1!.color!,fontSize: 12,
                ),),
                borderColor:Colors.grey[300]! ,
                height:mediaQuery.height/10 ,
                textColor: textColor,
                myDropDownItems: reminderList.map((e) {
                  return DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(e,
                          ),
                          const SizedBox(
                            width:60,
                          ),
                        ],
                      )
                  );
                }).toList(),
                validator: (value){},
                onChange: (value){
                 // setState((){
                 //   textColor=Colors.black;
                 // });
                }),
          ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 10.0),
                //   child: Text('Repeat',
                //     style: TextStyle(
                //       color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200]!,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   height:mediaQuery.height/12 ,
                //   child: myDropDownMenu(
                //       labelColor:Colors.white ,
                //       textColor: textColor2,
                //       hint: const Text('Daily',style: TextStyle(
                //         color: Colors.black,fontSize: 12,
                //       ),),
                //       borderColor:Colors.grey[200]! ,
                //       height:mediaQuery.height/14 ,
                //       myDropDownItems: repeatList.map((e) {
                //         return DropdownMenuItem(
                //             value: e,
                //             child: Row(
                //               children: [
                //                 Text(e,
                //                 ),
                //                 const SizedBox(
                //                   width:60,
                //                 ),
                //               ],
                //             )
                //         );
                //       }).toList(),
                //       validator: (value){},
                //       onChange: (value){
                //         setState((){
                //           textColor2=Colors.black;
                //         });
                //       }),
                // ),
                 SizedBox(
                  height: mediaQuery.height/14.toDouble(),
                ),
                MyElevatedButton(
                    radius: 6,
                    borderWidth: 1,
                    textColor: Colors.white,
                    fontSize: 16,
                    borderColor: Colors.green,
                    height: mediaQuery.height/16,
                    width: double.infinity,
                    onTap: ()async{
                      if(formKey.currentState!.validate()){
                       AppCubit.get(context).insertToDataBase(
                           title: titleController.text,
                           date: deadLineController.text,
                           time: endTimeController.text);
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BoardScreen()), (route) => false);
                       await notifications.displayNotification( );

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

   Widget myDropDownMenu<listName>({
    required Text hint,
     className,
     listName,
     myDropDownValue,
     required myDropDownItems,
     double height=60,
     required validator,
     required Function? onChange,
     Color borderColor = Colors.limeAccent,
     Color labelColor = Colors.white,
    required Color textColor ,

   }) {
     return Container(
       color: Theme.of(context).backgroundColor,
       child: DropdownButtonFormField(
            elevation: 6,
           borderRadius:BorderRadius.circular(30) ,
           onTap:(){} ,
           validator: validator,
           hint: hint,
           decoration: InputDecoration(
             hintStyle: TextStyle(color: Theme.of(context).textTheme.subtitle1!.color!),
             errorStyle:  const TextStyle(
                 fontSize: 12,
                 color: Colors.red),
             labelStyle: TextStyle(color: labelColor, fontSize: 12
             ),
             errorBorder:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
                 borderSide: const BorderSide(
                     width: 2,color: Colors.red
                 )
             ),
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(width: 3,color: Theme.of(context).textTheme.subtitle1!.color!
               ),
             ),
             enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
                 borderSide: BorderSide(
                     width: 3,color: borderColor
                 )
             ),
           ),
           dropdownColor: Theme.of(context).backgroundColor,
           style:  TextStyle(
             color: Theme.of(context).textTheme.subtitle1!.color!, fontSize: 14
           ),
           iconEnabledColor: Colors.grey[400],
           isExpanded: false,
           icon: const Icon(Icons.arrow_drop_down),
           iconSize: 20,
           menuMaxHeight:MediaQuery.of(context).size.height/5 ,
           focusColor: Colors.limeAccent,
           value: myDropDownValue,
           onChanged: (value) {
             // print(x.toString()+' on change');
             setState((){
               // print(x.toString()+' on Change + onchange');
               // textColor=Colors.black;
             }
             );
             onChange!(value);
           },
           items: myDropDownItems),
     );
   }
}
