import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
   UserItem({Key? key,required this.userMap}) : super(key: key);
  late Map userMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children:   [
          CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 25,
            child: Text(
              '${userMap['id']}',style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            ),
          ),
          const SizedBox(
            width: 20,),
          Expanded(
            child: Text('${userMap['name']}',style: const TextStyle(
                fontSize: 24,fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    );
  }
}
