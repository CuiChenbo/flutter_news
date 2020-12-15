import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/bean/ganhuo_banner_bean.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeBannerPage extends StatefulWidget {
  HomeBannerPage({Key key}) : super(key: key);

  @override
  _HomeBannerPageState createState() {
    return _HomeBannerPageState();
  }
}

GanhuoBannerBean _bannerBean;

class _HomeBannerPageState extends State<HomeBannerPage> with AutomaticKeepAliveClientMixin{
  Dio _dio = new Dio();

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
    return Container(
      child: FutureBuilder(
        future: _dio.get("https://gank.io/api/v2/banners"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            Map maps = json.decode(response.toString());
            _bannerBean = new GanhuoBannerBean.fromJson(maps);

            //发生错误
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Container(
              height: 160,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: new Image.network(
                      _bannerBean.data[index].image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: _bannerBean.data.length,
                loop: true,
                pagination: null,
                autoplay: true,
                viewportFraction: 0.8,
                scale: 0.9,
                onTap: (int index) {

                },
              ),
            );
          }
          return Image.asset(
            "assets/images/icon_qq.jpg",
            height: 160,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
