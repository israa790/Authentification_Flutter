import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Etudiant extends StatefulWidget {
  Etudiant(String s, String t, String u, String v, String w);

  @override
  _EtudiantState createState() => _EtudiantState();
}

class _EtudiantState extends State<Etudiant> {
  List<dynamic>? listEtd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etudiant'),
      ),
      body: Center(
          child: this.listEtd == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: (this.listEtd == null) ? 0 : listEtd!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: RaisedButton(
                        child: Text(listEtd![index]['nom']),
                        onPressed: () {},
                      ),
                    );
                  })),
    );
  }

  @override
  void initState() {
    super.initState();
    log("Loading etudiants");
    loadEtudiant();
  }

  void loadEtudiant() {
    String url = "http://192.168.56.1:8080/etudiants";
    http.get(Uri.parse(url)).then((resp) {
      //faite attnetion à se niveau là
      // risque d'erreur
      log(resp.body.toString());
      log(json.decode(resp.body)['_embedded']['etudiants']);
      setState(() {
        this.listEtd = json.decode(resp.body)['_embedded']['etudiants'];
      });
    }).catchError((err) {
      log(err.toString());
    });
  }
}
