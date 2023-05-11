class Product{
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  // we can access privat list(_products) from outside, using public one products
  List<ProductModel> get products => _products;

  Product({required totalSize, required typeId, required offset, required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  // turn the json(Map) into object
  Product.fromJson(Map<String,dynamic> json){
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if(json['products'] != null){
      _products = <ProductModel>[];
      json['products'].forEach((v){
        // store all json(Maps) as objects on list
        _products!.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel{
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typedId;


  ProductModel({
      this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typedId});

  // turn the json(Map) into object
  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typedId = json['type_id'];
  }

  // convert json to map/object
  Map<String, dynamic> toJson(){
    return{
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'description': this.description,
      'stars': this.stars,
      'img': this.img,
      'location': this.location,
      'created_at': this.createdAt,
      'updated_at': this.updatedAt,
      'type_id': this.typedId,
    };
  }

}