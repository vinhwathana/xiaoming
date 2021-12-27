import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future FetchData() async{
    final response = await http.get(Uri.https('https://{{domain}}/employees','1027'));
    return json.decode(response.body)['Data'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FetchData(),
        builder: (context,snapshot){
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data[index]['EmployeeID']),
                        //subtitle: Text(snapshot.data[index]['']),
                      ),
                    ],
                  ),
                );
          }
          );
        },
      ),
    );
  }
}
