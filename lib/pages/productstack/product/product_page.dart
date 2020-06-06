import 'package:flutter/material.dart';
import 'package:my_app/widgets/logo.dart';
import 'package:my_app/widgets/menu.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
              child: Text('Navagate To Detail'),
              onPressed: () => {
               Navigator.pushNamed(context, 'productstack/productdetail')
              },
            )
          ],
        ),
      ),
    );
  }
}
