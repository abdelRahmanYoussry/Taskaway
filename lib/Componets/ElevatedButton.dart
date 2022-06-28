import 'package:algorizainternship/Componets/ElevatedButton.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  void Function() onTap;
  final Color buttonColor;
  final Color textColor;
  final String buttonName;
  MyElevatedButton(
      this.height,this.width,
      this.onTap,this.buttonName,this.buttonColor,this.fontSize,this.radius,this.textColor);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width,
      height:height,
      child: ElevatedButton(onPressed: onTap,
          style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor,),
          shape:MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)
          ))
          )
      // ,style:ElevatedButton.styleFrom(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20)
      //     )
      //   )
          ,child:  Text(buttonName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize,color:textColor ),)),
    );
  }

}