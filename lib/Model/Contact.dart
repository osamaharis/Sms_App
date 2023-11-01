
class Contact {
  String number;
  Contact({ required this.number});

  factory Contact.fromJson(dynamic json){
    return Contact(
        number:"${json['user_contact']}"
    );
  }

  Map toJson()=>{
    "user_contact":number
  };
}