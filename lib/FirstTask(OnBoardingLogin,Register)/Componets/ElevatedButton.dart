import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  late double height;
  final double width;
   double ?borderWidth;
  late double? fontSize=14.0;
   double? radius;
  void Function() onTap;
  IconData? icon;
  AssetImage? image;
  final Color buttonColor;
   Color? borderColor;
  late Color? textColor;
  final String buttonName;
  MyElevatedButton({
      required this.height,required this.width,this.radius,this.fontSize,this.icon,this.image,
      required this.onTap,required this.buttonName,required this.buttonColor,this.textColor,
      this.borderColor,this.borderWidth

  });
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width:width,
      height:height,
      child: ElevatedButton(onPressed: onTap,
          style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor,),
          side: MaterialStateProperty.all(BorderSide(
            color: borderColor!,width:borderWidth!
          )),
          shape:MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??0)
          ))
          )
          ,child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(icon!=null)
              Icon(icon,),
              if(image!=null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(image: image!,fit: BoxFit.fill,width: 20,),
              ),
              Text(buttonName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize,color:textColor ),),
            ],
          )),
    );
  }

}