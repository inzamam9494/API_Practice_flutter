

class Photos{
  late String? title;
  late String? url;

  Photos({
    required this.title,
    required this.url
});

  factory Photos.fromJason(dynamic json) => Photos(
      title: json['title'],
      url: json['url']);

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map['title'] = title;
    map['url'] = url;
    return map;
  }

}