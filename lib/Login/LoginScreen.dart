import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: false,
       toolbarHeight: mediaQuery.height/4,
       flexibleSpace: Container(
         decoration: const BoxDecoration(
             image: DecorationImage(
                 image: AssetImage('assets/image/background.jpg'),
                 fit: BoxFit.fitWidth
             )
         ),
       ),
     ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             Text('Welcome to Fashion Daily ',
               style: Theme.of(context).textTheme.caption!.copyWith(fontSize:14 ),),
             SizedBox(height: 20,),
             Text('Sign in ',
               style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black),),
            SizedBox(height: 20,),
             Text('Phone Number ',
               style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
            TextFormField(

            )
          ],
        ),
      ),
    );
  }
}
