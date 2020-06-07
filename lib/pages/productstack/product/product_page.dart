import 'package:flutter/material.dart';
import 'package:my_app/models/product_modal.dart';
import 'package:my_app/widgets/logo.dart';
import 'package:my_app/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isLoading = true;
  List<Course> course = [];

  _getData() async {
    const url = 'https://api.codingthailand.com/api/course';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final product _product = product.fromJson(json.decode(response.body));
      setState(() {
        course = _product.course;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("Error : StatusCode ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
              onPressed: () => {},
            )
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(course[index].picture),
                              fit: BoxFit.cover)),
                    ),
                    title: Text('${course[index].title}'),
                    subtitle: Text('${course[index].detail}'),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('productstack/productdetail');
                    },
                  );
                },
                separatorBuilder: ((BuildContext context, index) => Divider()),
                itemCount: course.length));
  }
}
