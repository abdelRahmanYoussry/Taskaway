import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData lightTheme=  ThemeData(
    scaffoldBackgroundColor:Colors.white ,
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ) ,
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
    textTheme:const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
        subtitle1:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.3
        )
    ),
);

ThemeData darkTheme=  ThemeData(
     tabBarTheme:TabBarTheme(
       labelColor: Colors.white,
       unselectedLabelColor: Colors.red,
     ) ,
    scaffoldBackgroundColor: HexColor('333739'),
    backgroundColor:HexColor('333739') ,
    primaryColor:HexColor('333739') ,
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light
        ) ,
        color:HexColor('333739'),
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        iconTheme: const IconThemeData(
            color: Colors.white
        )
    ),
    textTheme:const TextTheme(
        bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        subtitle1:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.3
        ),
    ),
);