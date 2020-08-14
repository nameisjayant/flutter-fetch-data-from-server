import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Http request"),
        ),
        body: Server(),
      ),
    ));
  }
}

class Server extends StatefulWidget {
  _ServerState createState() => _ServerState();
}

class _ServerState extends State<Server> {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get("http://codingwithjks.tech/data.php");
    return json.decode(response.body);
  }

  String _name(dynamic actor) {
    return actor['name'];
  }

  String _age(dynamic actor) {
    return actor['age'].toString();
  }

  Widget build(BuildContext context) {
    return (FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return (ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return (Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(snapshot.data[index]['image']),
                        ),
                        title: Text(_name(snapshot.data[index])),
                        subtitle: Text(_age(snapshot.data[index])),
                      )
                    ],
                  ),
                ));
              }));
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
