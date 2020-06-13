import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/pages/redux/app_reducer.dart';
import 'package:my_app/pages/redux/auth/auth_action.dart';
import 'package:my_app/pages/redux/auth/auth_reducer.dart';
import 'package:my_app/widgets/logo.dart';
import 'package:my_app/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "CCT";
  bool isToggle = false;

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString("profile");
    var profile = jsonDecode(profileString);
    //call action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(profile));
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(title);
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (route) => false);
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
              icon: Icon(Icons.exit_to_app),
              onPressed: () => {_logout()},
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            StoreConnector<AppState, AuthState>(
                builder: (context, authStatus) {
                  return Expanded(
                    flex: 1,
                    child: Center(
                      child: Text('WelCome!!! ${authStatus.profile['name']}'),
                    ),
                  );
                },
                converter: (store) => store.state.authState),
            Expanded(
              flex: 10,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () =>
                        {Navigator.pushNamed(context, 'homestack/company')},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.business_center,
                            size: 90,
                            color: Colors.white,
                          ),
                          Text(
                            "บริษัท",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Heed not the rabble'),
                    color: Colors.teal[200],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Sound of screams but the'),
                    color: Colors.teal[300],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Who scream'),
                    color: Colors.teal[400],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution is coming...'),
                    color: Colors.teal[500],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
