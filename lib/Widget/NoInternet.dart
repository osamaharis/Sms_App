import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child:
        Center(
        child: Image.asset(
        "assets/no_internet.jpg",
        width: double.infinity,
        height: 250,
    )

    )


    );
  }
}
