import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserName extends ChangeNotifier {
  var name = "john kim";
  changeName() {
    name = "john park";
    notifyListeners();
  }
}

class Store1 extends ChangeNotifier {
  var name = "john kim";
  changeName() {
    name = "john park";
    notifyListeners();
  }

  var follower = 0;
  var clickfollowerbtn = true;
  chfollower() {
    if (clickfollowerbtn == true) {
      follower++;
      clickfollowerbtn = false;
      notifyListeners();
    } else if (clickfollowerbtn == false) {
      follower--;
      clickfollowerbtn = true;
      notifyListeners();
    }
  }

  var profileimage = [];
  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileimage = result2;
    notifyListeners();
  }
}
