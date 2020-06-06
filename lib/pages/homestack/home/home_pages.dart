import 'package:flutter/material.dart';
import 'package:my_app/widgets/logo.dart';
import 'package:my_app/widgets/menu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "CCT";
  bool isToggle = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>{

            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$title',
              style: Theme.of(context).textTheme.headline3,
            ),
            RaisedButton(
              child: Text('Click me'),
              onPressed: () => {
                setState(() {
                  isToggle = !isToggle;
                  isToggle ? title = 'CCT' : title = 'UUU';
                })
              },
            ),
             RaisedButton(
              child: Text('Navagate To Company'),
              onPressed: () => {
               Navigator.pushNamed(context, 'homestack/company')
              },
            )
          ],
        ),
      ),
    );
  }
}
