import 'package:MySMS/Model/Contact.dart';
import 'package:MySMS/Widget/ContactCardList.dart';
import 'package:MySMS/Widget/Extensions.dart';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert' as convert;

import 'package:rxdart/rxdart.dart' as RxDart;

import 'Widget/CustomProgressIndicator.dart';
import 'Widget/CustomTheme.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Contact> contactlist = [];

  bool _isloaded = true;
  String result = "";
  final scrollController = ScrollController();
  var en_message_Controller = TextEditingController();
  List<String> selectednumbers = [];
  Future<void> getNumberfromsheet() async {
    var rwa = await http.get(Uri.parse(
        "https://script.googleusercontent.com/macros/echo?user_content_key=WuWAuaYlVfPguTwyjta8jGIJhZ-z3XIvzDVzd1AS325-G7JJwgIIlFYvIthZK9Y6II8INpPlkFzZSD3rCUOJmdGCKNpthAMem5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnCljp9ZL91Q6YMVvUbzPAZgMnC91JAbfX-HycAsPz-FZ0DayXmSLGdhJt7xGtGDTAgqR6L0T1gsX3691yxXmxnX9z9ymcaMXCw&lib=MXnoYrom9SgRob9jUQnXiO5GHEo5vm62a"));
    //
    // https://script.googleusercontent.com/macros/echo?user_content_key=1O4VdMTU0ofzC6kYxsYmgJ6BnkbuiosqPCE43qf04ccj3GtBnj4KSCnp23sLrZHzF1SNusF7umTNO8dCIKemfQ9bBHxK-dS9m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnE92VXYoEhvqwzJKJ1__vlV6xhc-Rok86ctlpvHObvKM80EokVhm6F3JLF29Y4c18Itd0fBTlxX34TQT9im298ZAHa7lkDWJvw&lib=MXnoYrom9SgRob9jUQnXiO5GHEo5vm62a
    var jsonnumber = convert.jsonDecode(rwa.body);
    contactlist = [];
    jsonnumber.forEach((element) {
      Contact contact = Contact(
          number: element['user_contact'].toString(),
          value: element['check_box']);
      contactlist.add(contact);
    });
    setState(() {
      _isloaded = false;
      // contactlist = contactlist;
    });
  }

  @override
  void initState() {
    super.initState();
    getNumberfromsheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: Text(
              "GetAllContacts",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w300,
                  fontSize: plain_text_size.toDouble()),
            ),
          ),
          elevation: 0,
          backgroundColor: theme_color.toColor(),
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 30.0,
        ),
        body: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNumberfromsheet();
                },
                child: Container(
                    margin: EdgeInsets.all(5),
                    child: contactlist.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                              child: CustomProgressIndicator(),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            scrollDirection: Axis.vertical,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: contactlist.length,
                            itemBuilder: (context, index) {
                              return ContactcardList(
                                contact: contactlist[index],
                                //    number: contactlist[index].number.toString()
                              );
                              //  ListNumber(number: contactlist[index].number.toString());
                            })),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      minLines: 2,
                      //Normal textInputField will be displayed
                      maxLines: 2,

                      // when user presses enter it will adapt to it
                      keyboardType: TextInputType.multiline,
                      controller: en_message_Controller,
                      /*    inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z\s]*$')),
                        ],*/
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write your message';
                        }
                        return null;
                      },
                      autofocus: false,
                      style: TextStyle(
                          fontSize: otherText.toDouble(),
                          color: input_hint_head_color.toColor()),
                      decoration: InputDecoration(
                          enabled: true,
                          hintText: 'Enter your message.....',
                          hintStyle:
                              TextStyle(color: input_hint_color.toColor())),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: InkWell(
                        hoverColor: Colors.black12,
                        onTap: () {
                          if (en_message_Controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Enter a Message" ?? "")),
                            );
                          } else {
                             selectednumbers = contactlist
                                .where((element) => element.value)
                                .toList()
                                .map((e) => e.number)
                                .toList();
                            if (selectednumbers.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Select at least one item to send.")),
                              );
                            }

                            else {
                              requestSmsPermission();

                            }
                          }

                        },
                        child: Icon(
                          Icons.send_sharp,
                          color: theme_color.toColor(),
                          size: 30,
                        )),
                  ),
                ),
                // Circlebutton(name: "Send", onClick: (){}, color: theme_color.toColor()),
              ],
            )
          ],
        ));
  }

  // SendMessage() async {
  //   bool result = await BackgroundSms.isSupportCustomSim as bool;
  //   if (result) {
  //     String results = (await BackgroundSms.sendMessage(
  //             phoneNumber: contactlist.length.toString(),
  //             message: en_message_Controller.text.toString(),
  //             simSlot: 1))
  //         .toString();
  //     if (results == SmsStatus.sent) {
  //       print("Sent");
  //     } else {
  //       print("Failed");
  //     }
  //   } else {
  //     print("Not Support Custom Sim Slot");
  //     String result = await BackgroundSms.sendMessage(
  //             phoneNumber: contactlist.length.toString(),
  //             message: en_message_Controller.text.toString())
  //         .toString();
  //     if (result == SmsStatus.sent) {
  //       print("Sent");
  //     } else {
  //       print("Failed");
  //     }
  //   }
  // }

  Future<String> sendingSms(String message, List<String> contact) async {
    result = await sendSMS(message: message, recipients: contact,sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    //return result;
    //}
    return result;

    //print(result);
  }
  Future<void> requestSmsPermission()async
  {
    final PermissionStatus status = await Permission.sms.request();
    if (status.isGranted) {
      sendingSms(
          en_message_Controller.text.toString(),
          selectednumbers
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Sent.")),
      );
      en_message_Controller.text="";
      // You have SMS permissions.
      // You can now proceed to send SMS messages.
    } else {
      // Handle the case where the user denies SMS permissions.
      if (status.isDenied) {
        showsAlertDialog(context,"If you dont allow permission you cant send messages to users","Alert","OK","Cancel",0);
      }
    }
  }
  showsAlertDialog(BuildContext context, String message, String heading,
      String buttonAcceptTitle, String buttonCancelTitle, int index) {
    Widget cancelButton = TextButton(
      child: Text(
        buttonCancelTitle,
        style: TextStyle(
            color: Colors.white,
            fontSize: plain_text_size.toDouble(),
            fontWeight: FontWeight.w400),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(theme_color.toColor()),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: theme_color.toColor())))),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(buttonAcceptTitle,
          style: TextStyle(
              color: Colors.white,
              fontSize: plain_text_size.toDouble(),
              fontWeight: FontWeight.w400)),
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(theme_color.toColor()),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: theme_color.toColor())))),
      onPressed: () {
        requestSmsPermission();
            }

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(10.0),
      actionsPadding: EdgeInsets.all(10.0),
      icon: Icon(
        Icons.error,
        size: 50.0,
        color: Colors.red,
      ),
      title: Text(heading),
      content: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: heading_text_size.toDouble(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Future<void> sendDelayedMessages(
  //     List<Contact> contacts, String message) async {
  //   for (Contact contact in contacts) {
  //     await Future.delayed(Duration(seconds: 5)); // Add a delay of 5 seconds
  //     // Send the message to the current contact
  //     String result =
  //         await sendSMS(message: message, recipients: [contact.number]);
  //
  //     if (result == 'sent') {
  //       print('Message sent to ${contact.number}');
  //     } else {
  //       print('Failed to send message to ${contact.number}');
  //     }
  //   }
  // }
  //
  // void startSendingMessages() {
  //   String message = en_message_Controller.text.toString();
  //   sendDelayedMessages(contactlist, message);
  // }
}




class ListNumber extends StatelessWidget {
  String number;

  ListNumber({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        "Contact No:${number.toString()}",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
