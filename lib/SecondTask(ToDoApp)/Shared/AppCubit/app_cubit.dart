import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../Local/cash_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);
  late Database database;
  bool isChecked=false;
  List<Map> allTasks = [];
  List<Map> completeTasks = [];
  List<Map> unCompleteTasks = [];
  List<Map> favouriteTasks = [];
  List<Map> scheduleTasks = [];
  void changeCheckBox(bool checked){
    isChecked= checked;
    emit(ChangeCheckBox());
  }

  void createDataBase()  {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint("database has created");
        database
            .execute(
            'CREATE TABLE Taskawy (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT,startTime TEXT,reminder TEXT,body TEXT)')
            .then((value) {
          debugPrint("Table has created");
        }).catchError((error) {
          debugPrint("error is : ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        debugPrint("database has opened");
      },
    ).then((value) {
      database=value;
      emit(CreateDataBase());
    });
  }




  insertToDataBase(
      {required String title,
        required String date,
        required String time,
        required String startTime,
        required String reminder,
        required String body,
        //  bool isChecked=false,
        // required Color taskColor,

      }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO Taskawy(title, date, time, status, startTime, reminder, body) VALUES( "$title", "$date", "$time", "all", "$startTime", "$reminder", "$body")')
          .then((value) {
        debugPrint("$value inserted successfully");
        getDataFromDataBase(database);

        emit(InsertToDataBase());
      }).catchError((onError) {
        debugPrint('The Error while insert is ${onError.toString()}');
      });
    });
  }

  void getDataFromDataBase (dataBase)
  {
    allTasks=[];
    completeTasks=[];
    favouriteTasks=[];
    unCompleteTasks=[];
    dataBase.rawQuery('SELECT * FROM Taskawy').then((value) {
      value.forEach((element) {
        // debugPrint(element['status']);
        allTasks.add(element);
         if(element['status']=='complete') {
          completeTasks.add(element);
        }
        else if(element['status']=='unComplete'){
          unCompleteTasks.add(element);
        }
        else if(element['status']=='favourite'){
          favouriteTasks.add(element);
        }
         else if(element['status']=='all'){
           unCompleteTasks.add(element);
         }
        // debugPrint(element['status']);
      });
      emit(GetFromDataBase());
    });
  }

  void getDateToScheduleTable (dataBase,{required String date})
  {
   scheduleTasks.clear();
    dataBase.rawQuery('SELECT * FROM Taskawy WHERE date = ?', [date]).then((value) {
      value.forEach((element) {
        // debugPrint(element['date']+'abbbbbbbbbbbbbbbbbbbbb');
        if(element['date']==date){
        scheduleTasks.add(element);
        // debugPrint(element['schedule table']);

      }
      });

      emit(GetFromScheduleTable());
    });
  }

  void changeStatus({required String status,required int id})
  {
    database.rawUpdate(
        'UPDATE Taskawy SET status = ? WHERE id = ?',
        [status, id]
    ).then((value) {
      debugPrint(value.toString());
      getDataFromDataBase(database);
      // getDateToScheduleTable(database, date: DateFormat.yMMMd().format(DateTime.now()));
      emit(ChangeStatus());


    });
  }

  void updateData({
    required String title,
    required String body,
    required String startTime,
    required String endTime,
    required String reminder,
    required int id})
  {
    database.rawUpdate(
        'UPDATE Taskawy SET title = ?, body = ?, startTime = ?, time = ?, reminder = ?  WHERE id = ?',
        [title,body,startTime,endTime,reminder, id]
    ).then((value) {
      debugPrint(value.toString());
      getDataFromDataBase(database);
      emit(UpdateTask());


    });
  }


  void deleteData({required int id})
  {
    database.rawDelete(
        'DELETE FROM Taskawy WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteFromDataBase());
    });
  }

  bool isDark= false;
  void changeDarkMode({bool? fromShared})
  {
    if(fromShared!=null){

      isDark=fromShared;

      emit(ChangeAppMode());
    }
    else
    {
      isDark=!isDark;
      CashHelper.putBool(key: 'isDark', value: isDark).
      then((value) {
        debugPrint(isDark.toString());
        emit(ChangeAppMode());
      });}

  }

}
