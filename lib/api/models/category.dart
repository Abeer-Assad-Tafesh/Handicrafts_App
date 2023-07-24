class Category {
  late int id;
  late int? parentId;
  late String name;
  late String description;
  late String image;
  late String status;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    return data;
  }
}