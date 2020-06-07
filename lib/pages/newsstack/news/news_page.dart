import 'package:flutter/material.dart';
import 'package:my_app/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int totalResults = 0;
  List<dynamic> articles = [];
  bool isLoading = true;

  _getData() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=th&apiKey=cdd2353c9ffc43b7a6b599194f5bcd00&page=1&pageSize=5';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final Map<String, dynamic> news = json.decode(response.body);
      setState(() {
        totalResults = news['totalResults'];
        articles = news['articles'];
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
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
            title:
                totalResults > 0 ? Text('ข่าวสาร $totalResults ข่าว') : null),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                      child: Ink.image(
                                          image: NetworkImage(
                                              articles[index]['urlToImage']),
                                          fit: BoxFit.cover)),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    right: 20,
                                    top: 20,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.bottomCenter,
                                    child: Text(
                                      articles[index]['source']['name'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                },
                separatorBuilder: ((BuildContext context, index) => Divider()),
                itemCount: articles.length));
  }
}
