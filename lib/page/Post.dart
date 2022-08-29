import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Profile.dart';

class Post extends StatefulWidget {
  Post({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  getmoredata() async {
    var moredata = await http
        .get(Uri.parse('https://codingapple1.github.io/app/more2.json'));
    var moredata2 = jsonDecode(moredata.body);
    setState(() {
      widget.data.add(moredata2);
    });
  }

  var scroll = ScrollController();

  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getmoredata();
      }
    });
  }

  setImage(i) {
    if (widget.data[i]["image"].runtimeType == String) {
      return Image.network(
        widget.data[i]["image"],
        fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        widget.data[i]["image"],
        fit: BoxFit.fill,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
        controller: scroll,
        itemCount: widget.data.length,
        itemBuilder: (c, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setImage(i),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(widget.data[i]["user"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => Profile(),
                              transitionsBuilder: (c, a1, a2, child) =>
                                  SlideTransition(
                                position: Tween(
                                  begin: Offset(-1.0, 0.0),
                                  end: Offset(0.0,
                                      0.0), // -1.0은 왼쪽에서,위에서 아래로1.0은 오른쪽,아래에서 위로                                  end: Offset(0.0, 0.0),
                                ).animate(a1),
                                child: child,
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        "좋아요 ${widget.data[i]['likes']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.data[i]['date']),
                      Text(widget.data[i]['content']),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      );
    } else {
      return Text("로딩중");
    }
  }
}
