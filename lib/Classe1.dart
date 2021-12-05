import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'AddEtudiant.dart';

class Classe1 extends StatefulWidget {
  const Classe1({Key? key}) : super(key: key);

  @override
  _Classe1State createState() => _Classe1State();
}

class _Classe1State extends State<Classe1> {
  List<dynamic>? listClasses;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
        primary: Theme.of(context).colorScheme.onBackground);
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes List'),
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
        child: this.listClasses == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount:
                    (this.listClasses == null) ? 0 : this.listClasses!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      deleteClasse(listClasses![index]['codClass']);
                    },
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                          color: Color.fromRGBO(189, 18, 224, 1.0),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child:
                                  Text(this.listClasses![index]['nomClass']))),
                    ),
                  );
                }),
      ),
    );
  }

  void getClasses() {
    String url = "http://192.168.56.1:8080/classes";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.listClasses = json.decode(resp.body)['_embedded']['classes'];
      });
    }).catchError((err) {
      print(err);
    });
  }

  Future deleteClasse(int id) async {
    String url = "http://192.168.56.1:8080/classes";
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
    getClasses();
  }
}
