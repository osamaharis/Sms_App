
import 'package:MySMS/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);


@override
   State<SplashScreen> createState() => _SplashScreen();


}
class _SplashScreen extends State<SplashScreen>

{

  @override
  void initState() {
    super.initState();
    navigation();
  }

  navigation()async {
    await Future.delayed(Duration(milliseconds:1500 ),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          Container(
            child: Text("SMS APP",style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),),
          ),
        ],
      )
      ,
    );
  }
}

