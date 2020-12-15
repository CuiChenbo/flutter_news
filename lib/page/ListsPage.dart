import 'package:flutter/material.dart';
import 'package:flutter_news/page/Image200Page.dart';
import 'package:flutter_news/page/MeiziGridPage.dart';

class ListsPage extends StatefulWidget {
  ListsPage({Key key}) : super(key: key);

  @override
  _ListsPageState createState() {
    return _ListsPageState();
  }
}

class _ListsPageState extends State<ListsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          Image200Page(),

          MeiziGridPage(),
          //List
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                child: new Text('加载完成'),
              );
            }, childCount: 1
                ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
