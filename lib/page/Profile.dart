import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Store1.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.watch<UserName>().name),
        ),
        body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (c, i) {
            return Container(
              color: Colors.grey,
            );
          },
          itemCount: 3,
        ));
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => UserName()),
        ChangeNotifierProvider(create: (c) => Store1())
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
          ),
          Text("팔로워 ${context.watch<Store1>().follower}명"),
          ElevatedButton(
              onPressed: () {
                context.read<Store1>().chfollower();
              },
              child: const Text("팔로우")),
          ElevatedButton(
              onPressed: () {
                context.read<Store1>().getData();
              },
              child: const Text("가져오기")),
        ],
      ),
    );
  }
}
