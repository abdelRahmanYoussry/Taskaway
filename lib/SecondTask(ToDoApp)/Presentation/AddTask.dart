import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/AllTasks.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Widget/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../FirstTask(OnBoardingLogin,Register)/Componets/ElevatedButton.dart';
import 'Board.dart';

class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({Key? key}) : super(key: key);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: mediaQuery.height/10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {Navigator.pop(context);  },
        ),
        titleTextStyle: const TextStyle(
            color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold
        ),
        elevation: 1,
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Title',
                    style: TextStyle(
                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                MyTextFormField(
                  textInputFormat:"[a-z A-Z0-9 ]",
                  labelColor: Colors.white,
                  onChanged: (value){},
                  onTap: (){},
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title Can't be Empty";
                    }
                    return null;
                  },
                  readOnly: false,
                  borderColor: Colors.grey[200]!,
                  backgroundColor: Colors.grey[200]!,
                  type: TextInputType.text,
                  hint: 'Task Title',
                  control: titleController,
                  textColor: Colors.black,
                  isPassword: false,),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('DeadLine',
                    style: TextStyle(
                      color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                MyTextFormField(
                  labelColor: Colors.white,
                  onChanged: (value){},
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
                  textColor: Colors.black,
                  isPassword: false,),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Start Time',
                            style: TextStyle(
                              color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                        ),
                        SizedBox(
                          width: mediaQuery.width/2.5,
                          child: MyTextFormField(
                            labelColor: Colors.white,
                            onChanged: (value){},
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
                            suffixIconColor: Colors.grey[400],
                            control: startTimeController,
                            textColor: Colors.black,
                            isPassword: false,),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('End Time',
                            style: TextStyle(
                              color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                        ),
                        SizedBox(
                          width: mediaQuery.width/2.5,
                          child: MyTextFormField(
                            labelColor: Colors.white,
                            onChanged: (value){},
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
                            suffixIconColor: Colors.grey[400],
                            textColor: Colors.black,
                            isPassword: false,),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Reminder',
                    style: TextStyle(
                      color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                const SizedBox(
                  height: 10,
                ),
               Container(
            decoration: BoxDecoration(
              color: Colors.grey[200]!,
              borderRadius: BorderRadius.circular(10),
            ),
            height:mediaQuery.height/12 ,
            child: myDropDownMenu(
              labelColor:Colors.white ,
                hint: const Text('1 hour before',style: TextStyle(
                  color: Colors.grey,fontSize: 12,
                ),),
                borderColor:Colors.grey[200]! ,
                height:mediaQuery.height/14 ,
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
                onChange: (value){}),
          ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Repeat',
                    style: TextStyle(
                      color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold ,),),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200]!,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height:mediaQuery.height/12 ,
                  child: myDropDownMenu(
                      labelColor:Colors.white ,
                      hint: const Text('Daily',style: TextStyle(
                        color: Colors.grey,fontSize: 12,
                      ),),
                      borderColor:Colors.grey[200]! ,
                      height:mediaQuery.height/14 ,
                      myDropDownItems: repeatList.map((e) {
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
                      onChange: (value){}),
                ),
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
                    onTap: (){
                      if(formKey.currentState!.validate()){
                       AppCubit.get(context).insertToDataBase(
                           title: titleController.text,
                           date: deadLineController.text,
                           // taskColor: Colors.blue,
                           time: endTimeController.text);
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BoardScreen()), (route) => false);
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

   }) {
     return SizedBox(
       height:height,width: double.infinity,
       child: DropdownButtonFormField(
           validator: validator,
           hint: hint,
           decoration: InputDecoration(
             errorStyle:  const TextStyle(
                 fontSize: 12,
                 color: Colors.red),
             labelStyle: TextStyle(color: labelColor,
                 fontSize: 14
             ),
             errorBorder:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
                 borderSide: const BorderSide(
                     width: 2,color: Colors.red
                 )
             ),
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                   width: 2,color: borderColor
               ),
             ),
             enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
                 borderSide: BorderSide(
                     width: 2,color: borderColor
                 )
             ),
           ),
           dropdownColor: Colors.black.withOpacity(0.1),
           style: const TextStyle(
             fontSize: 16,
             color: Colors.white,
           ),
           iconEnabledColor: Colors.grey[400],
           isExpanded: true,
           icon: const Icon(Icons.arrow_drop_down),
           iconSize: 20,
           menuMaxHeight: 200,
           focusColor: Colors.limeAccent,
           value: myDropDownValue,
           onChanged: (value) {
             onChange!(value);
           },
           items: myDropDownItems),
     );
   }

}
