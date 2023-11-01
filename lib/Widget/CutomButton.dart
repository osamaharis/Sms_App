import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final Color color;

  CustomButton(
      {Key? key,
      required this.name,
      required this.onClick,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          onClick();
        },
        child: Ink(
          child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                elevation: 2,
                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              )),
        ));
  }
}
