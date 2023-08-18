
class CommonQuestion {
  late int id;
  late String title;
  late String desc;

  CommonQuestion.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      title = json['title'];
      desc = json['desc'];
  }
}
