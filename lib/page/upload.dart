import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Upload extends StatefulWidget {
  Upload({Key? key, this.userImage, this.data}) : super(key: key);
  final data;
  var userImage;

  final TextEditingController text = TextEditingController();
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var now = DateFormat.MMMd('en_US').format(DateTime.now());

  addpost(context, userImage, text) {
    if (userImage != null) {
      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(
              userImage,
              fit: BoxFit.fitWidth,
              height: 300,
              width: double.infinity,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: text,
                ))
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addpost(context, widget.userImage, widget.text),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.data.insert(0, {
                      "id": widget.data.length,
                      "image": widget.userImage,
                      "likes": 0,
                      "date": now,
                      "content": widget.text.text,
                      "user": "사람"
                    });
                  });

                  Navigator.pop(context);
                },
                child: Text(
                  "게시",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]));
  }
}
