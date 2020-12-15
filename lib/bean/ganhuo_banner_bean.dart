/// data : [{"image":"http://gank.io/images/cfb4028bfead41e8b6e34057364969d1","title":"干货集中营新版更新","url":"https://gank.io/migrate_progress"},{"image":"http://gank.io/images/aebca647b3054757afd0e54d83e0628e","title":"- 春水初生，春林初盛，春风十里，不如你。","url":"https://gank.io/post/5e51497b6e7524f833c3f7a8"},{"image":"https://pic.downk.cc/item/5e7b64fd504f4bcb040fae8f.jpg","title":"盘点国内那些免费好用的图床","url":"https://gank.io/post/5e7b5a8b6d2e518fdeab27aa"}]
/// status : 100

class GanhuoBannerBean {
  List<Data> data;
  int status;

  GanhuoBannerBean({
      this.data, 
      this.status});

  GanhuoBannerBean.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["status"] = status;
    return map;
  }

}

/// image : "http://gank.io/images/cfb4028bfead41e8b6e34057364969d1"
/// title : "干货集中营新版更新"
/// url : "https://gank.io/migrate_progress"

class Data {
  String image;
  String title;
  String url;

  Data({
      this.image, 
      this.title, 
      this.url});

  Data.fromJson(dynamic json) {
    image = json["image"];
    title = json["title"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = image;
    map["title"] = title;
    map["url"] = url;
    return map;
  }

}