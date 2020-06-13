import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/pages/redux/app_reducer.dart';
import 'package:my_app/pages/redux/auth/auth_action.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

// _getProfile() async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var profileString = prefs.getString("profile");
//   var profile = jsonDecode(profileString);
//   //call action
//   final store = StoreProvider.of<AppState>(context);
//   store.dispatch(getProfileAction(profile));
// }

// @override
// void initState() { 
//   super.initState();
//   _getProfile();
// }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          StoreConnector<AppState, Map<String, dynamic>>(
            distinct: true,
            converter: (store) => store.state.authState.profile,
            builder: (context, profile) {
              return UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/me.jpg'),
                ),
                accountEmail: Text("${profile['email']} role : ${profile['role']}"),
                accountName: Text("${profile['name']}"),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("หน้าหลัก"),
            selected: ModalRoute.of(context).settings.name == 'homestack/home'
                ? true
                : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () => {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/', (route) => false)
            },
          ),
          ListTile(
            leading: Icon(Icons.insert_photo),
            title: Text("สินค้า"),
            selected:
                ModalRoute.of(context).settings.name == 'productstack/product'
                    ? true
                    : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () => {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/product', (route) => false)
            },
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('ข่าวสาร'),
            trailing: Icon(Icons.arrow_right),
            selected: ModalRoute.of(context).settings.name == 'newsstack/news'
                ? true
                : false,
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/newsstack', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
