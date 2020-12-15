import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/bean/news_list_bean.dart';
import 'package:flutter_news/page/HomeBannerPage.dart';

class HomeListViewPage extends StatefulWidget {
  HomeListViewPage({Key key}) : super(key: key);

  @override
  _HomeListViewPageState createState() {
    return _HomeListViewPageState();
  }
}

class _HomeListViewPageState extends State<HomeListViewPage> {
  NewsListBean _newsListBean;
  Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = new Dio();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dio.get("https://api.ithome.com/json/newslist/news?r=497159860"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container(
              height: 600,
              child: ListView.builder(
                itemCount: 60,
                itemExtent: 60.0,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(title: Text("数据错误 $index"),);
                },
              ),
            );
          }

          Map map = json.decode(snapshot.data.toString());
          _newsListBean = NewsListBean.fromJson(map);
          _newsListBean.newslist.insert(0,null);//插入一个Banner数据

          return Container(
            height: 500,
            child: ListView.separated(
              itemCount: _newsListBean.newslist.length,
              //列表项构造器
              itemBuilder: (BuildContext context, int index) {
                if(_newsListBean.newslist[index] == null){
                  return HomeBannerPage();
                }
                return ListItem(index);
              },
              //分割器构造器
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.blue,
                  height: 0.5,
                );
              },
            ),
          );
        }
        return CupertinoActivityIndicator();
      },
    );
  }

  Widget ListItem(int index){
   return Container(
      height: 80,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 3, 8, 3),
        child: Row(
          children: [
            Container(
              width: 200,
              child: Column(
                children: [
                  Text(
                    _newsListBean.newslist[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4),),
                  Text(
                    _newsListBean.newslist[index].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    _newsListBean.newslist[index].image,
                    fit: BoxFit.cover,
                    height: 68.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
