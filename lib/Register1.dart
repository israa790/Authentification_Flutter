import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'User.dart';
import 'login1.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.56.1:8080/register";
  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.pop(context);
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
                            Text('Register',
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
                                          builder: (context) => Login1()));
                                },
                                child: Text(
                                  "Already Have Account ?",
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
                            save();
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
