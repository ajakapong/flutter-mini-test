import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("บริษัท")),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
              image: AssetImage('assets/images/building.png'),
              fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text('New Normal',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Divider()
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
