import 'package:flut_3/Theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import "dart:io";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'Providers/Store1.dart';
import 'page/Post.dart';
import 'page/upload.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => UserName()),
      ChangeNotifierProvider(create: (c) => Store1())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: theme,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var tab = 0;
  var data = [];
  var userImage;

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));

    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    var map = {"age": 20};
    storage.setString("map", jsonEncode(map));
  }

  @override
  void initState() {
    super.initState();
    saveData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Instagram",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => Upload(
                        userImage: userImage,
                        data: data)), //=> 는 return(이랑 똑같음)
              ).then(((value) {
                print("asd");
                setState(() {});
              }));
            },
            iconSize: 30,
          )
        ],
      ),
      body: PageView(
        controller: PageController(
          initialPage: 0, //0번째를 먼저 보여줌
        ),
        children: [
          Post(data: data),
          Text("샵"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false, //선택한 라벨 이름 보여주기
        showUnselectedLabels: false, //선택안된 라벨 이름 보여주기
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "홈"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: "샵"),
        ],
      ),
    );
  }
}
