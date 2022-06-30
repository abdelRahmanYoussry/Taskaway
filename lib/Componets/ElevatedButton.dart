import 'package:algorizainternship/Componets/ElevatedButton.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  late double height;
  final double width;
  late double? fontSize=14.0;
  final double? radius;
  void Function() onTap;
  final Color buttonColor;
  late Color? textColor;
  final String buttonName;
  MyElevatedButton({
      required this.height,required this.width,this.radius,this.fontSize,
      required this.onTap,required this.buttonName,required this.buttonColor,this.textColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width,
      height:height,
      child: ElevatedButton(onPressed: onTap,
          style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor,),
          shape:MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)
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