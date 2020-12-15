import 'package:flutter/material.dart';

class Image200Page extends StatefulWidget {
  Image200Page({Key key}) : super(key: key);

  @override
  _Image200PageState createState() {
    return _Image200PageState();
  }
}

class _Image200PageState extends State<Image200Page> {
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

    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        child: Image.network(
          "https://gank.io/images/e56da642238a43c4971f12d4e3395f30",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}