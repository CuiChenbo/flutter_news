import 'package:flutter/material.dart';
import 'package:flutter_news/page/HomePage.dart';
import 'package:flutter_news/page/ListsPage.dart';
import 'package:flutter_news/page/MyPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drawer/LiftDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List pages;
  PageController _controller;
  
  
  @override
  void initState() {
    super.initState();
    pages = [HomePage() , ListsPage(),MyPage()];
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      drawer: LiftDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_media_outlined), title: Text("妹纸")),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined), title: Text("段子"))
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onControllerTap,
      ),

      
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index){
          return pages[index];
        },
        controller: _controller,
        onPageChanged: (int index){
          _onItemTap(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _Add,
      ),
    );
  }

  void _onItemTap(int index) {
    print("ccb $index");
    setState(() {
      _selectedIndex = index;
    });
  }


  void _onControllerTap(int index) {
      _controller.jumpToPage(index);
  }

  void _Add() {
    Fluttertoast.showToast(msg: "ADD",
       );
  }
}
