import 'dart:math';

class likedUniversity {
  int id = 0;
  String name = "";
  String url = "";

  likedUniversity(this.name, this.url);
  likedUniversity.withId({required this.id, required this.name});

  Map<String, dynamic> toKeyValue() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["url"] = url;
    if (id != null) {
      map["id"] = Random().nextInt(10000);
    }
    return map;
  }

  likedUniversity.fromKeyValue(dynamic uni) {
    this.id = int.parse(uni["id"].toString());
    this.name = uni["name"];
    this.url = uni["url"];
  }
}
