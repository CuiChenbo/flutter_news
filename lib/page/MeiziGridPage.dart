import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/bean/meizi_bean.dart';

import 'PhotoViewGalleryScreen.dart';

class MeiziGridPage extends StatefulWidget {
  MeiziGridPage({Key key}) : super(key: key);

  @override
  _MeiziGridPageState createState() {
    return _MeiziGridPageState();
  }
}

MeiziBean _meiziBean;

class _MeiziGridPageState extends State<MeiziGridPage> {
  @override
  void initState() {
    super.initState();
    goHttp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Dio _dio = new Dio();

  Future<void> goHttp() async {
    Response response = await _dio.get(
        "https://gank.io/api/v2/data/category/Girl/type/Girl/page/2/count/50");
    Map maps = json.decode(response.toString());
    _meiziBean = new MeiziBean.fromJson(maps);
    setData();
  }

  void setData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_meiziBean == null) {
      return SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: new SliverGrid(
        //Grid
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Grid按两列显示
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          // childAspectRatio: 4.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            //创建子widget
            return new Container(
                height: 260,
                child: GestureDetector(
                  child: Image.network(
                    _meiziBean.data[index].url,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {

                      //允许多查看5张图片
                      List<String> lists = new List();
                      if (_meiziBean.data.length > index + 5) {
                        for (int i = index; i < index + 5; i++) {
                          lists.add(_meiziBean.data[i].url);
                        }
                      } else {
                        lists.add(_meiziBean.data[index].url);
                      }
                      print(lists.length);
                      return PhotoViewGalleryScreen(
                        images: lists,
                        index: 0,
                        heroTag: 'simple',
                      );
                    }));
                  },
                ));
          },
          childCount: _meiziBean.data.length,
        ),
      ),
    );
  }
}
