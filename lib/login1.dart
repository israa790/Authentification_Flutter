import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Dashboard.dart';

import 'Register1.dart';
import 'User.dart';

class Login1 extends StatefulWidget {
  const Login1({Key? key}) : super(key: key);

  @override
  _Login1State createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.56.1:8080/login";
  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);

    if (res.body != null) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 600,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(189, 18, 224, 1.0),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Text('Login',
                                style: GoogleFonts.pacifico(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Email",
                                  style: GoogleFonts.roboto(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                  )),
                            ),
                            TextFormField(
                              controller:
                                  TextEditingController(text: user.email),
                              onChanged: (val) {
                                user.email = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email is empty !!';
                                }
                                return '';
                              },
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              decoration: InputDecoration(
                                  //  errorStyle: TextStyle(
                                  //     fontSize: 20, color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                            Container(
                              height: 1,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Password",
                                  style: GoogleFonts.roboto(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                  )),
                            ),
                            TextFormField(
                              controller:
                                  TextEditingController(text: user.password),
                              onChanged: (val) {
                                user.password = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is empty !!';
                                }
                                return '';
                              },
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              decoration: InputDecoration(
                                  // errorStyle: TextStyle(
                                  //    fontSize: 20, color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                            Container(
                              height: 1,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: Text(
                                  "Don't  Have Account ?",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      child: FlatButton(
                          color:
                              Color.fromRGBO(133, 5, 161, 0.9137254901960784),
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            save();
                            // }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          )),
                    )
                  ],
                ))));
  }
}
