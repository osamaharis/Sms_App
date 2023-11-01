
import 'package:flutter/material.dart';


class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(strokeWidth: 2,
      backgroundColor:Color(0x33B3B3B3),
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),));
  }
}
