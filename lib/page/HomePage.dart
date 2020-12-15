import 'package:flutter/material.dart';
import 'package:flutter_news/page/HomeListViewPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
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
    // return ListView(
    //   children: [
    //     HomeBannerPage(),
    //     HomeListViewPage(),
    //   ],
    // );
    return HomeListViewPage();
  }

  @override
  bool get wantKeepAlive => true;
}
