
import 'package:flutter/material.dart';


class LiftDrawer extends StatelessWidget {
  LiftDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/icon_qq.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "CCB",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('（づ￣3￣）づ╭❤～'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('啪啪'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
