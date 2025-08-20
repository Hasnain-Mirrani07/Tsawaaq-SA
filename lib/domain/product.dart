class Product {
  int? id;
  String? category;
  String? name;
  String? desc;
  dynamic price;
  String? image;
  String? offer;
  dynamic quantity;

  Product(
      {this.id,
      this.category,
      this.name,
      this.desc,
      this.price,
      this.image,
      this.offer,
      this.quantity});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
    offer = json['offer'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['image'] = this.image;
    data['offer'] = this.offer;
    data['quantity'] = this.quantity;
    return data;
  }
}
