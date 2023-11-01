import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/Widget/Extensions.dart';

import 'CustomTheme.dart';

class ContactcardList extends StatefulWidget {
  ContactcardList({Key? key, required this.number}) : super(key: key);
  String number;

  @override
  State<ContactcardList> createState() => _ContactcardListState();
}

class _ContactcardListState extends State<ContactcardList> {
  bool isChecked = true; // Initialize the checkbox to be checked.

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        height: 50,
        width: double.maxFinite,
        child: Row(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              widget.number,
                              style: TextStyle(
                                  fontSize: plain_text_size.toDouble(),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: Transform.scale(
                                scale: 1.2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Checkbox(
                                    activeColor: theme_color.toColor(),
                                    value: isChecked,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    onChanged: (bool? value) {
                                      isChecked = value ?? false;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}