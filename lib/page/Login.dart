import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  getregister() async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: "k62533196@gmail.com", password: "123456");
      result.user?.updateDisplayName('jaehee');
      print(result.user);
    } catch (e) {
      print(e);
    }
  }

  getlogin() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: "k62533196@gmail.com", password: "123456");
    } catch (e) {
      print(e);
    }

    if (auth.currentUser?.uid == null) {
      print("로그인 안된상태");
    } else {
      print("로그인함");
    }
  }

  getlogout() async {
    await auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    getregister();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextButton(
            child: Text("로그인"),
            onPressed: () {
              getlogin();
            },
          ),
          TextButton(
            child: Text("로그아웃"),
            onPressed: () {
              getlogout();
            },
          ),
          TextButton(
              onPressed: () {
                if (auth.currentUser?.uid == null) {
                  print("로그인 안된상태");
                } else {
                  print("로그인함");
                }
              },
              child: Text("현재상태"))
        ],
      )),
    );
  }
}
