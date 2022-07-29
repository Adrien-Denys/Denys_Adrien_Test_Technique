import 'package:flutter/material.dart';
import 'package:myapp/models/User.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(
        height: 180,
        width: 160,
        decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Image.network(
                    user.imageUrl.toString(),
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  user.lastName.toString() + " " + user.firstName.toString(),
                ),
              ),
            ],
          ),
        ),
      )
    ])));
  }
}
