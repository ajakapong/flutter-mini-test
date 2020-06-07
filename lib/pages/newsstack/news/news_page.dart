import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int totalResults = 0;
  List<dynamic> articles = [];
  bool isLoading = true;
  int pages = 1;
  int pageSizes = 5;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      articles.clear();
      pages = 1;
    });
    _getData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
     _refreshController.resetNoData();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    print(pages);
    if (pages < (totalResults / pageSizes).ceil()) {
      if (mounted)
        setState(() {
          pages = ++pages;
        });
      _getData();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
       _refreshController.resetNoData();
    }
  }

  _getData() async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=th&apiKey=cdd2353c9ffc43b7a6b599194f5bcd00&page=$pages&pageSize=$pageSizes';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final Map<String, dynamic> news = json.decode(response.body);
      setState(() {
        totalResults = news['totalResults'];
        articles.addAll(news['articles']);
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
          title: totalResults > 0 ? Text('ข่าวสาร $totalResults ข่าว') : null),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: ClassicHeader(
                refreshStyle: RefreshStyle.Follow,
                refreshingText: 'กำลังโหลดข้อมูล',
                completeText: 'โหลดข้อมูลเสร็จเรียบร้อย',
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("กำลังโหลดข้อมูล....");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else if (mode == LoadStatus.loading) {
                    body = Text("ไม่มีข้อมูลแล้ว....");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'newsstack/webview',arguments: {
                              'name' :articles[index]['source']['name'],
                              'url':articles[index]['url']
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${articles[index]['urlToImage']}',
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Column(
                                    children: <Widget>[
                                      Text(articles[index]['title']),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                alignment: Alignment(-1.0, 0.0),
                                                child: articles[index]
                                                            ['author'] !=
                                                        null
                                                    ? Chip(
                                                        avatar:
                                                            Icon(Icons.pages),
                                                        label: articles[index][
                                                                        'author']
                                                                    .length <
                                                                30
                                                            ? Text(
                                                                articles[index]
                                                                    ['author'])
                                                            : Text(articles[index]
                                                                    ['author']
                                                                .substring(0, 30)))
                                                    : Text('')),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                                DateFormat.yMMMd()
                                                    .add_Hms()
                                                    .format(DateTime.parse(
                                                        articles[index]
                                                            ['publishedAt'])),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                          )
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          )),
                    );
                  },
                  separatorBuilder: ((BuildContext context, index) =>
                      Divider()),
                  itemCount: articles.length),
            ),
    );
  }
}
