import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Circlebutton extends StatelessWidget {
  Circlebutton(
      {Key? key,
      required this.name,
      required this.onClick,
      required this.color})
      : super(key: key);
  final String name;
  final VoidCallback onClick;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width:50.0,
      height:50.0,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
      ),
      child: Center(child: Text(name,style: TextStyle(
        color: Colors.white,
            fontWeight: FontWeight.w200,
        fontSize: 12
      ),)),

    );
  }
}
