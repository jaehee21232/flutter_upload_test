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
  @override
  getlogin() async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: "k62533196@gmail.com", password: "123456");
      result.user?.updateDisplayName('jaehee');
      print(result.user);
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getlogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
        TextButton(child: Text("로그인"),,)
      ),
    );
  }
}
