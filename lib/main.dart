import 'package:algorizainternship/SecondTask(ToDoApp)/Shared/Local/cash_helper.dart';
import 'package:algorizainternship/SecondTask(ToDoApp)/Style/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SecondTask(ToDoApp)/Presentation/Board.dart';
import 'SecondTask(ToDoApp)/Shared/AppCubit/BlocObserver.dart';
import 'SecondTask(ToDoApp)/Shared/AppCubit/app_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
 await CashHelper.init();
 bool ?isDark;
 if(CashHelper.getData(key:'isDark')==null){
   isDark=false;
 }
 else{
   isDark=CashHelper.getData(key:'isDark');
 }
 // bool isDark= CashHelper.getData(key:'isDark')?CashHelper.getData(key:'isDark'):false;
 // debugPrint(isDark.toString());
  runApp( MyApp(isDark:isDark! ,));
}

class MyApp extends StatelessWidget {
 final bool isDark;
   const MyApp({Key? key,required this.isDark}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..createDataBase()..changeDarkMode(fromShared:isDark )
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        theme:lightTheme,
        darkTheme:darkTheme ,
        themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
        // ThemeData(
        //   appBarTheme:const AppBarTheme(
        //     systemOverlayStyle: SystemUiOverlayStyle.light,
        //   ),
        //   primarySwatch: Colors.blue,
        // ),
        // darkTheme: ThemeData(
        //   backgroundColor: Colors.black,
        // ),
        home:  BoardScreen(),
        navigatorKey: navigatorKey,
      );
  },
),
    );
  }
}


