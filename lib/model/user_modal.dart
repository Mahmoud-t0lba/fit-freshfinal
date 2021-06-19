import 'package:flutter/cupertino.dart';

class UserModal extends ChangeNotifier {
  String email;
  bool isAdmin;
  String name;
  String phone;
  String photo;

  UserModal({
    this.email,
    this.isAdmin,
    this.name,
    this.phone,
    this.photo
  });

  UserModal.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    email = json['email'];
    isAdmin = json['isAdmin'];
    name = json['name'];
    phone = json['phone'];
    photo =json['photo'];
  }

  toJson() {
    return {
      'email': email,
      'isAdmin': isAdmin,
      'name': name,
      'phone': phone,
      'photo':photo,
    };
  }


}
