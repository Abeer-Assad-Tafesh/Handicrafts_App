class Category {
  late int id;
  late int? parentId;
  late String name;
  late String? description;
  late String? image;
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
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'description': description,
      'image': image,
      'status': status,
    };
  }
}