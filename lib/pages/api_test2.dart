import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getUserData() async {
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u['name'], u['email'], u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User Data'),
    ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot){
              if(snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data.length,
                        itemBuilder: (context, i){
                      return ListTile(
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].userName),
                        trailing: Text(snapshot.data[i].email),
                      );
              });
            },
          ),
        ),
      )
    );
  }
}

class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}