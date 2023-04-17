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
   int ?taskId;
  bool isChecked=false;
  int ?differenceDaysMinutes;
  int ?differenceDaysSeconds;
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
      'tasksAway.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint("database has created");
        database
            .execute(
            'CREATE TABLE Taskawy (id INTEGER PRIMARY KEY,title TEXT,endDate TEXT,endTime TEXT,status TEXT,startTime TEXT,reminder TEXT,body TEXT,'
                'remainingMinutes INTEGER,remainingHours INTEGER,remainingDays INTEGER,startDate Text)')
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

 Future<int>  daysBetween(DateTime from, DateTime to)async {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    int resultInMinutes;
    int resultInSecond;
      resultInMinutes=( to.difference(from).inHours / 24).round();
      resultInSecond=( to.difference(from).inSeconds).round();
      differenceDaysMinutes=resultInMinutes;
      differenceDaysSeconds=resultInSecond;
    debugPrint('${differenceDaysMinutes} Dayessssssssssssssssssss in minutes');
    debugPrint('${differenceDaysSeconds} Dayessssssssssssssssssss in Seconds');
    return resultInMinutes;
  }


  Future<int>  hoursBetween(DateTime from, DateTime to)async {
    from = DateTime(from.hour, from.minute,);
    to = DateTime(to.hour, to.minute,);
    int result;
    result=( to.difference(from).inMinutes).round();
    debugPrint('${result} Hoursssssssssssssss');
    return result;
  }

  // String intToTimeLeft(int value) {
  //   int h, m, s;
  //
  //   h = value ~/ 60;
  //
  //   m = ((value - h * 60)) ~/ 2;
  //
  //   s = value - (h * 60) - (m * 1);
  //
  //   String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();
  //
  //   String minuteLeft =
  //   m.toString().length < 2 ? "0" + m.toString() : m.toString();
  //
  //   String secondsLeft =
  //   s.toString().length < 2 ? "0" + s.toString() : s.toString();
  //
  //   String result = "$hourLeft:$minuteLeft:$secondsLeft";
  //    print(result+' intToTimeLeft');
  //   return result;
  // }

  String differenceFormattedString(int minute) {
    try {
      DateTime now = DateTime.now();
      Duration difference = Duration(minutes: minute);
      final today = DateTime(now.year).add(difference).subtract(const Duration(days: 1));
     var result='${today.day} Days ${today.hour} Hours ${today.minute} Min';
      debugPrint(result);
      return '${today.day} Days ${today.hour} Hours ${today.minute} Min';
    } catch (e) {
      return '';
    }
  }

  insertToDataBase(
      {required String title,
        required String endDate,
        required String StartDate,
        required String endTime,
        required String startTime,
        required String reminder,
        required String body,
        required int remainingMinutes ,
        required int remainingHours ,
        required int remainingDays ,
      }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO Taskawy(title, endDate, endTime, status, startTime, reminder, body, remainingMinutes , remainingHours , remainingDays , startDate ) '
              'VALUES( "$title", "$endDate", "$endTime", "all", "$startTime", "$reminder", "$body" , "$remainingMinutes" , "$remainingHours" , "$remainingDays" , "$StartDate")')
          .then((value) async {
        debugPrint("$value inserted successfully");
        // debugPrint("$value [id]");
      await  getDataFromDataBase(database);

        emit(InsertToDataBase());
      }).catchError((onError) {
        debugPrint('The Error while insert is ${onError.toString()}');
      });
    });
  }

 Future <void> getDataFromDataBase (dataBase)
  async {
    allTasks=[];
    completeTasks=[];
    favouriteTasks=[];
    unCompleteTasks=[];
    dataBase.rawQuery('SELECT * FROM Taskawy').then((value) {
      value.forEach((element) async {
        // debugPrint(element['status']);
        allTasks.add(element);
        // debugPrint('${element['id']}   this is Id');
        taskId=element['id'];
        debugPrint('$taskId   this is taskId');
        debugPrint('${element['title']}   this is title');
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
    dataBase.rawQuery('SELECT * FROM Taskawy WHERE endDate = ?', [date]).then((value) {
      value.forEach((element) {
        // debugPrint(element['date']+'abbbbbbbbbbbbbbbbbbbbb');
        if(element['endDate']==date){
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

 Future<void>  updateData({
    required String title,
    required String body,
    required String startTime,
    required String endTime,
    required String reminder,
    required String endDate,
    required String startDate,
    required int id,
   required int remainingMinutes ,
   required int remainingHours ,
   required int remainingDays ,

 })
  async {
  await  database.rawUpdate(
        'UPDATE Taskawy SET title = ?, body = ?, startTime = ?, endTime = ?, reminder = ? , endDate = ? , remainingMinutes = ? , remainingHours = ? , remainingDays = ? , startDate = ? WHERE id = ?',
        [title,body,startTime,endTime,reminder,endDate,remainingMinutes,remainingHours,remainingDays,startDate ,id]
    ).then((value) async {
      debugPrint(value.toString());
     await getDataFromDataBase(database);
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
