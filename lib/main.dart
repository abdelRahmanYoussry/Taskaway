import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SecondTask(ToDoApp)/Presentation/Board.dart';
import 'SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..createDataBase()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        theme: ThemeData(
          appBarTheme:const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          primarySwatch: Colors.blue,
        ),
        home:  BoardScreen(),
      ),
    );
  }
}


