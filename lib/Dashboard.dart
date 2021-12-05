import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'AddEtudiant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic>? listEtudiants;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
        primary: Theme.of(context).colorScheme.onBackground);
    return Scaffold(
      appBar: AppBar(
        title: Text('Students List'),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEtudiant()));
            },
            child: const Text('ADD'),
          ),
        ],
      ),
      body: Center(
        child: this.listEtudiants == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: (this.listEtudiants == null)
                    ? 0
                    : this.listEtudiants!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      deleteStudent(listEtudiants![index]['id']);
                    },
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                          color: Color.fromRGBO(189, 18, 224, 1.0),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(this.listEtudiants![index]['nom']))),
                    ),
                  );
                }),
      ),
    );
  }

  void getEtudiants() {
    String url = "http://192.168.56.1:8080/etudiants";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.listEtudiants = json.decode(resp.body)['_embedded']['etudiants'];
      });
    }).catchError((err) {
      print(err);
    });
  }

  Future deleteStudent(int id) async {
    String url = "http://192.168.56.1:8080/etudiants";
    final response = await delete(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erreur');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEtudiants();
  }
}
