import 'package:flutter/material.dart';

class One extends StatelessWidget {
const One({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Material(
      child:  Container(
        color: Colors.amber,
        child: const Center(
          child: Text('WELCOME',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}