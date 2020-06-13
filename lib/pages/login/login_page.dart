import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autovalidate = false;

  _login(Map<String, dynamic> formValues) async {
    var url = "https://api.codingthailand.com/api/login";
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": formValues["email"],
          "password": formValues["password"]
        }));
    if (response.statusCode == 200) {
      var token = jsonDecode(response.body);

      //SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);

      //getProfile
      var urlGetProfile = "https://api.codingthailand.com/api/profile";
      var responseProfile = await http.get(
        urlGetProfile,
        headers: {'Authorization': 'Bearer ${token['access_token']}'},
      );
      var resp = jsonDecode(responseProfile.body);
      var profile = resp['data']['user'];

      await prefs.setString('profile', jsonEncode(profile));

      //goto HomeStack
      Navigator.pushNamedAndRemoveUntil(
          context, '/homestack', (route) => false);
    } else {
      var resp = jsonDecode(response.body);
// Flushbar(
//   title: "Hey Ninja",
//   message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
//   backgroundColor: Colors.red,
//   boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
// )..show(context);
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
                FlutterLogo(size: 80),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        FormBuilder(
                          key: _fbKey,
                          initialValue: {
                            'email': '',
                            'password': '',
                          },
                          autovalidate: _autovalidate,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                attribute: "email",
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle:
                                        TextStyle(color: Colors.black12),
                                    icon: Icon(Icons.email),
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
                                    icon: Icon(Icons.vpn_key),
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
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                padding: EdgeInsets.all(30),
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    _login(_fbKey.currentState.value);
                                  } else {
                                    setState(() {
                                      _autovalidate = true;
                                    });
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
                                "สมัครสมาชิก",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                            ),
                            MaterialButton(
                              child: Text(
                                "ลิมรหัสผ่าน",
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
