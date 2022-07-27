import 'package:algorizainternship/Counter%20(bloc)/Cubit/Cubit.dart';
import 'package:algorizainternship/Counter%20(bloc)/Cubit/States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Style/Colors.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return CounterCubit();
      },
      child: BlocConsumer<CounterCubit,CounterState>(
        listener: (context,state){},
        builder: (context,state){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Text('Counter with Bloc',
             style: TextStyle(
               fontSize: 28,fontWeight: FontWeight.bold
             ),),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,


                children: [
                  FloatingActionButton(onPressed: (){
                    CounterCubit.get(context).increment();

                  },
                    backgroundColor: mainColor,child: const Icon(Icons.add),),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(CounterCubit.get(context).counter.toString(),style: TextStyle(
                        color: mainColor,fontSize: 24,fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  FloatingActionButton(onPressed: (){
                    CounterCubit.get(context).decrement();
                  },
                    backgroundColor: mainColor,child: const Icon(Icons.remove),),
                ],
              )
            ],
          );
        },

      ),
    );
  }
}
