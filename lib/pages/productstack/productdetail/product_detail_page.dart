import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map<String, dynamic> course;

  _getData(int id) async {
    try {
      var url = 'https://api.codingthailand.com/api/course/$id';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //print(response.body);
        final Map<String, dynamic> detail = json.decode(response.body);
        return detail;
      } else {
        throw Exception('เกิดข้อผิดพลาดในการแสดงข้อมูล ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      print(course['id']);
      _getData(course['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
 course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('${course['title']}')),
      body: FutureBuilder<dynamic>(
        future: _getData(course['id']),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Text(snapshot.data['data'][index]['ch_title']),
                  );
                },
                separatorBuilder: (BuildContext context, index) => Divider(),
                itemCount: snapshot.data['data'].length);
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center( child: CircularProgressIndicator() );
        },
      ),
    );
  }
}
