import 'package:algorizainternship/FirstTask(OnBoardingLogin,Register)/Componets/Componets.dart';
import 'package:algorizainternship/FirstTask(OnBoardingLogin,Register)/Componets/ElevatedButton.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Presentation/EditTask.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Map detailsModel;
  Color taskColor ;
   TaskDetailsScreen({Key? key,required this.detailsModel,required this.taskColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: taskColor,
            borderRadius:BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer,color:Colors.white),
                    const SizedBox(width: 5,),
                    Text('${detailsModel['startTime']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,),),
                    const Spacer(),
                    Text('${detailsModel['time']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,),),
                    const SizedBox(width: 5,),
                    const Icon(Icons.timer,color: Colors.white),
                  ],
                ),
                const SizedBox(height: 20,),
                Text('${detailsModel['title']}',
                  style: const TextStyle(
                    color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,),),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text('${detailsModel['body']}',maxLines: 3,
                        style: const TextStyle(
                          color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,overflow: TextOverflow.ellipsis),),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text('${detailsModel['reminder']}',
                  style: const TextStyle(
                    color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,),),
                Padding(
                    padding:  const EdgeInsets.symmetric(vertical: 10.0),
                    child:detailsModel['status']=='all'?   const Text('unComplete',
                      style: TextStyle(
                        color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,),):
                    Text('${detailsModel['status']}',
                      style: const TextStyle(
                        color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ,),)

                ),
                const Spacer(),
                MyElevatedButton(
                  radius: 20,
                  borderWidth: 1,
                  textColor: Colors.white,
                  fontSize: 16,
                  borderColor: detailsModel['status']=="complete"?Colors.red:Colors.green,
                  height: mediaQuery.height/16,
                  width: double.infinity,
                  buttonColor: detailsModel['status']=="complete"?Colors.red:Colors.green,
                  onTap: () {
                    navigateTo(context, widget: EditTaskScreen( editModel: detailsModel,));
                  },
                  buttonName: 'Edit Task',

                )
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
