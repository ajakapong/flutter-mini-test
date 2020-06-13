import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  _register(Map<String, dynamic> formValues) async {
    var url = "https://api.codingthailand.com/api/register";
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": formValues['name'],
          "email": formValues['email'],
          "password": formValues['password'],
          "dob": formValues['dob'].toString().substring(0, 10)
        }));
    print(formValues);
    if (response.statusCode == 201) {
      var resp = jsonDecode(response.body);
      // print(resp['message']);

      Flushbar(
        message: resp['message'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      )..show(context);

      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      var resp = jsonDecode(response.body);
      Flushbar(
        message: resp['errors']['email'][0],
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.red[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      )..show(context);
      // print(resp['errors']['email'][0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red, Colors.orangeAccent, Colors.yellowAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'ลงทะเบียน',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        FormBuilder(
                          key: _fbKey,
                          initialValue: {
                            'name': '',
                            'email': '',
                            'password': '',
                            'dob': DateTime.now()
                          },
                          autovalidate: true,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                attribute: "name",
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "ชื่อ-สกุล",
                                    labelStyle:
                                        TextStyle(color: Colors.black12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent)),
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: 'กรุณาใส่ชื่อ-สกุล'),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderDateTimePicker(
                                attribute: "dob",
                                inputType: InputType.date,
                                format: DateFormat("yyyy-MM-dd"),
                                decoration: InputDecoration(
                                    labelText: "วัน/เดือน/ปี เกิด",
                                    labelStyle:
                                        TextStyle(color: Colors.black12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                attribute: "email",
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle:
                                        TextStyle(color: Colors.black12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent)),
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: 'ป้อนอีเมลด้วย'),
                                  FormBuilderValidators.email(
                                      errorText: 'รูปแบบอีเมลไม่ถูกต้อง'),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                attribute: "password",
                                maxLines: 1,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle:
                                        TextStyle(color: Colors.black12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent)),
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: 'ป้อนรหัสด้วย'),
                                  FormBuilderValidators.minLength(3,
                                      errorText:
                                          'รหัสผ่านต้อง 3 ตัวอักษรขึ้นไป'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 250,
                              child: RaisedButton(
                                child: Text(
                                  'สมัครสมาชิก',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                padding: EdgeInsets.all(30),
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    _register(_fbKey.currentState.value);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            MaterialButton(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                            ),
                            MaterialButton(
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                _fbKey.currentState.reset();
                              },
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
