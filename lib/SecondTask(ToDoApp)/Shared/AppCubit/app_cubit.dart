import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

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
      'todo2.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint("database has created");
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
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
        //  bool isChecked=false,
        // required Color taskColor,

      }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES( "$title", "$date", "$time", "all" )')
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
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        debugPrint(element['status']);
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
    dataBase.rawQuery('SELECT * FROM tasks WHERE date = ?', [date]).then((value) {
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

  void updateData({required String status,required int id})
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value) {
      // debugPrint(value.toString());
      getDataFromDataBase(database);
      emit(UpdateDataBase());

    });
  }

  void deleteData({required int id})
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteFromDataBase());
    });
  }
}
