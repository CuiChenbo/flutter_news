import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/bean/video_list_bean.dart';
import 'package:flutter_news/page/player/VideoPlayerPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() {
    return _MyPageState();
  }
}

VideoListBean _videoListBean;

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    page = 1;
    goHttp(page);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Dio _dio = new Dio();

  int page = 1;

  void goHttp(int page) async {
    Response response = await _dio
        .get("https://api.apiopen.top/getJoke?page=$page&count=20&type=video");
    Map maps = json.decode(response.toString());
    print(response.data.toString());
    var videoListBean = new VideoListBean.fromJson(maps);
    setData(videoListBean);
  }

  void setData(VideoListBean videoListBean) {
    if (_videoListBean == null) {
      _videoListBean = videoListBean;
    } else {
      _videoListBean.result.addAll(videoListBean.result);
    }
    setState(() {});
  }

  void _onLoading() {
    goHttp(++page);
    _refreshController.loadComplete();
  }

  void _onRefresh() {
    _videoListBean = null;
    page = 1;
    goHttp(page);
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_videoListBean == null) {
      return Container(
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(),
      );
    }

    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      controller: _refreshController,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          return Container(
            height: 55.0,
            child: Center(child: CupertinoActivityIndicator()),
          );
        },
      ),
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey.shade300,
            height: 0.5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ListItem(index);
        },
        itemCount: _videoListBean.result.length,
      ),
    );

  }

  Widget ListItem(int index) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 33,
            child: Row(
              children: [
                ClipOval(
                  child:
                  Image.network(_videoListBean.result[index].header),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                ),
                Text(
                  _videoListBean.result[index].name,
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Wrap(
              children: [
                Text(
                  _videoListBean.result[index].text,
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return VideoPlayerPage(
                    videoUrl: _videoListBean.result[index].video);
              }));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              height: 150,
              child: Stack(
                children: [
                  Image.network(
                    _videoListBean.result[index].thumbnail,
                    fit: BoxFit.cover,
                    height: 150,
                    width: (MediaQuery
                        .of(context)
                        .size
                        .width - 40),
                  ),
                  Center(
                    child: Icon(
                      Icons.play_circle_outline_sharp,
                      color: Colors.white70,
                      size: 40,
                    ),

                  ),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
