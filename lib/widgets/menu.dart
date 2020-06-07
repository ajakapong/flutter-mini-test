import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/me.jpg'),
            ),
            accountEmail: Text("ajakapong@gmail.com"),
            accountName: Text("Jakapong"),
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
