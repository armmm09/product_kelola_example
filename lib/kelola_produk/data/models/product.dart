
class Product {
  int? id;
  String? name;
  int? price;
  int? stock;
  String? image;

  Product({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
   name = json['name'] as String;
    price= json['price'] as int?;
    stock = json['stock'] as int?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'image': image,
    };
  }
}