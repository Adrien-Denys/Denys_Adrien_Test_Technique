import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/models/User.dart';
import 'package:myapp/screens/components/UserCard.dart';
import 'package:myapp/models/Db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/api.dart';
import '../models/User.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  Future<Users> getData() async {
    Users result = Users();
    Map<String, dynamic> apiData = <String, dynamic>{};
    Future<Map<String, dynamic>> jsonData =
        Api.getData("https://randomuser.me/api/?results=100");

    await jsonData.then((value) => {
          apiData = value,
          result = Users.fromJson(apiData),
        });

    return result;
  }

  Future<List<User>> start() async {
    Users userList;
    Future<Users> results = getData();
    await results.then((value) {
      userList = value;
    });

    Db db = Db();
    Database database;

    List<User> userDatabaseList = [];
    Future<List<Map<String, dynamic>>> databaseData;

    Future<Database> fDatabase = db.initializeDb();
    await fDatabase.then((value) async => {
          database = value,
          await results.then(
            (value) {
              userList = value;
              db.fillData(database, userList);
            },
          ),
          databaseData = db.getUsers(database),
          await databaseData.then((value) => {
                for (Map<String, dynamic> user in value)
                  {userDatabaseList.add(User.fromDatabaseMap(user))},
              })
        });
    return userDatabaseList;
  }

  List<User> filterUser(String text, List<User> data) {
    var results;

    results = data.where((user) => user.firstName == text).toList();

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<User>>(
            future: start(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              TextEditingController searchBar = TextEditingController();
              String filter = "";
              var data;
              List<User> userLists = [];
              if (snapshot.hasData) {
                if (filter.isNotEmpty) {
                  data = filterUser(filter, snapshot.data);
                } else {
                  data = snapshot.data;
                }

                return Center(
                  child: Column(children: [
                    Container(
                      child: AppBar(
                        actions: [
                          Expanded(
                              child: TextField(
                                  controller: searchBar,
                                  onChanged: (txt) {
                                    if (searchBar.text != null) {
                                      filter = txt;
                                      // data = filterUser(filter, snapshot.data);
                                    }
                                  }))
                        ],
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              return UserCard(data[index]);
                            }))
                  ]),
                );
              } else {
                return Container();
              }
            }));
  }
}
