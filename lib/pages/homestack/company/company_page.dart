import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      Text('New Normal',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      Divider(),
      Text(
          'Where does it come from?Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'),
      SizedBox(
        width: 20,
      ),
      Column(
        children: <Widget>[Icon(Icons.wb_cloudy)],
      ),
      SizedBox(
        width: 20,
      ),
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[Text('jakapong')],
          ),
          Row(
            children: <Widget>[Text('09999999')],
          )
        ],
      ),
      Divider(),
      Wrap(
          spacing: 8,
          children: List.generate(
              7,
              (index) => Chip(
                    label: Text('Text ${index + 1}'),
                    avatar: Icon(Icons.star),
                    backgroundColor: Colors.orange,
                  ))),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
              backgroundImage: AssetImage('assets/images/me.jpg'), radius: 30),
          CircleAvatar(
              backgroundImage: AssetImage('assets/images/me.jpg'), radius: 30),
          CircleAvatar(
              backgroundImage: AssetImage('assets/images/me.jpg'), radius: 30),
        ],
      ),
      SizedBox(
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.star),
            Icon(Icons.star_half),
          ],
        ),
      )
    ];
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children2,
              ),
            ),
          )
        ],
      )),
    );
  }
}
