import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    var result = await firestore.collection('product').get();
    for (var doc in result.docs) {
      print(doc['name']); //모든 문서가져와서 name 출력
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("샵"),
    );
  }
}
