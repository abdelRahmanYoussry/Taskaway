import 'package:algorizainternship/Counter%20(bloc)/Cubit/States.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState>{
  CounterCubit():super(InitialState());
  static CounterCubit get(context)=>BlocProvider.of(context);
  int counter=1;
  void increment(){
    counter++;
    emit(IncrementState());
  }
  void decrement(){
    counter--;
    emit(DecrementState());
  }
}