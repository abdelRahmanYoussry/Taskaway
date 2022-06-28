import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget{
  final bool readOnly = false;
      late  TextEditingController control;
  late TextInputType type;
  late dynamic validator;
  Function? onSubmit;
  Function? onChanged;
      Function()? onTap;
  bool isPassword = false;
      late String label;
      late IconData prefix;
      IconData? suffix;
  Function()? suffixClicked;
      Color borderColor = Colors.limeAccent;
  Color labelColor = Colors.white;
      Color textColor = Colors.white;
  Color backgroundColor = Colors.blueGrey;
      Color prefixIconColor = Colors.limeAccent;
  String ? textInputFormat;
  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('$textInputFormat')),],
      readOnly: readOnly,
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (value) {
        onChanged!(value);
      },
      style: TextStyle(color: textColor,
          fontSize: 18),
      decoration: InputDecoration(
        errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.red),
        fillColor: backgroundColor.withOpacity(0.5),
        filled: true,
        labelText: label,
        labelStyle: TextStyle(color: labelColor, fontSize: 14),
        prefixIcon: Icon(prefix, color: prefixIconColor,),
        suffixIcon: suffix != null ? IconButton(
          onPressed: () {
            suffixClicked!();
          },
          icon: Icon(suffix),
        ) : null,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 3),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 6),
            borderRadius: BorderRadius.circular(20)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 6),
            borderRadius: BorderRadius.circular(10)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 6),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );

    //   TextFormField(
    //   inputFormatters: [FilteringTextInputFormatter.allow(RegExp('$textInputFormat')),],
    //   readOnly: readOnly,
    //   controller: control,
    //   keyboardType: type,
    //   validator: validator,
    //   onFieldSubmitted: (s) {
    //     onSubmit!(s);
    //   },
    //   onTap: () {
    //     onTap!();
    //   },
    //   obscureText: isPassword,
    //   onChanged: (value) {
    //     onChanged!(value);
    //   },
    //   style: TextStyle(color: textColor,
    //       fontSize: 18),
    //   decoration: InputDecoration(
    //     errorStyle: TextStyle(
    //         fontSize: 12,
    //         color: Colors.red),
    //     fillColor: backgroundColor.withOpacity(0.5),
    //     filled: true,
    //     labelText: label,
    //     labelStyle: TextStyle(color: labelColor, fontSize: 14),
    //     prefixIcon: Icon(prefix, color: prefixIconColor,),
    //     suffixIcon: suffix != null ? IconButton(
    //       onPressed: () {
    //         suffixClicked!();
    //       },
    //       icon: Icon(suffix),
    //     ) : null,
    //     enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: borderColor, width: 3),
    //         borderRadius: BorderRadius.circular(10)
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: borderColor, width: 6),
    //         borderRadius: BorderRadius.circular(20)
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: Colors.red, width: 6),
    //         borderRadius: BorderRadius.circular(10)
    //     ),
    //     errorBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: Colors.red, width: 6),
    //         borderRadius: BorderRadius.circular(10)
    //     ),
    //   ),
    // );
  }
  
}