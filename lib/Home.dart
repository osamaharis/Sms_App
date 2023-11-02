import 'package:MySMS/Model/Contact.dart';
import 'package:MySMS/Widget/ContactCardList.dart';
import 'package:MySMS/Widget/Extensions.dart';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;
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

  Future<void> getNumberfromsheet() async {
    var rwa = await http.get(Uri.parse(
        "https://script.googleusercontent.com/macros/echo?user_content_key=1O4VdMTU0ofzC6kYxsYmgJ6BnkbuiosqPCE43qf04ccj3GtBnj4KSCnp23sLrZHzF1SNusF7umTNO8dCIKemfQ9bBHxK-dS9m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnE92VXYoEhvqwzJKJ1__vlV6xhc-Rok86ctlpvHObvKM80EokVhm6F3JLF29Y4c18Itd0fBTlxX34TQT9im298ZAHa7lkDWJvw&lib=MXnoYrom9SgRob9jUQnXiO5GHEo5vm62a"));
    var jsonnumber = convert.jsonDecode(rwa.body);
    jsonnumber.forEach((element) {
      Contact contact = Contact(number: element['user_contact'].toString());
      contactlist.add(contact);
    });
    setState(() {
      contactlist = contactlist;
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
                                number: contactlist[index].number.toString());
                            //  ListNumber(number: contactlist[index].number.toString());
                          })),
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
                        border:
                            Border.all( color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: InkWell(
                      hoverColor: Colors.black12,
                        onTap: () {
                          if (en_message_Controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Enter a Message" ?? "")),
                            );
                          } else {
                            // sendDelayedMessages(contactlist,en_message_Controller.text.toString());
                            //  startSendingMessages();
                            sendingSms(en_message_Controller.text.toString(),
                                contactlist);
                          }

                          // SendMessage();
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

  Future<String> sendingSms(String message, List<Contact> contact) async {
    List<String> phoneNumbers =
        contact.map((contact) => contact.number).toList();
    for (Contact contact in contact) {
      Future.delayed(Duration(seconds: 2));
      result = await sendSMS(message: message, recipients: phoneNumbers)
          .catchError((onError) {
        print(onError);
      });
      //return result;
    }
    return result;

    //print(result);
  }

  Future<void> sendDelayedMessages(
      List<Contact> contacts, String message) async {
    for (Contact contact in contacts) {
      await Future.delayed(Duration(seconds: 5)); // Add a delay of 5 seconds
      // Send the message to the current contact
      String result =
          await sendSMS(message: message, recipients: [contact.number]);

      if (result == 'sent') {
        print('Message sent to ${contact.number}');
      } else {
        print('Failed to send message to ${contact.number}');
      }
    }
  }

  void startSendingMessages() {
    String message = en_message_Controller.text.toString();
    sendDelayedMessages(contactlist, message);
  }
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
