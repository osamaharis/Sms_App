class Contact {
  String number;
  bool value;

  Contact({required this.number, required this.value});

  factory Contact.fromJson(dynamic json) {
    return Contact(number: "${json['user_contact']}", value: json['check_box']);
  }

  Map toJson() => {"user_contact": number, "check_box": value};
}
