class CartActionsResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  CartActionsResponse.makeError({this.error, this.errorMsg});
  CartActionsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  CartActionsResponse({this.status, this.message, this.data});

  CartActionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  dynamic subtotal;
  dynamic discount;
  dynamic delivery;
  dynamic total;
  String? currency;
  dynamic totalCount;
  List<Cart>? cart;

  Data(
      {this.subtotal,
      this.discount,
      this.delivery,
      this.total,
      this.currency,
      this.totalCount,
      this.cart});

  Data.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal_formatted'];
    discount = json['discount'];
    delivery = json['delivery'];
    totalCount = json['count'];
    total = json['total'];
    currency = json['currency'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart?.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal_formatted'] = this.subtotal;
    data['discount'] = this.discount;
    data['delivery'] = this.delivery;
    data['total'] = this.total;
    data['count'] = this.totalCount;
    data['currency'] = this.currency;
    if (this.cart != null) {
      data['cart'] = this.cart?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? cartId;
  Product? product;
  int? count;
  dynamic totalPrice;
  ProductColor? color;
  ProductSize? size;
  int? quantity;

  Cart(
      {this.cartId,
      this.product,
      this.count,
      this.totalPrice,
      this.color,
      this.quantity,
      this.size});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    count = json['count'];
    totalPrice = json['total_price'];
    color =
        json['color'] != null ? new ProductColor.fromJson(json['color']) : null;
    size = json['size'] != null ? new ProductSize.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product?.toJson();
    }
    data['count'] = this.count;
    data['total_price'] = this.totalPrice;

    if (this.color != null) {
      data['color'] = this.color?.toJson();
    }
    if (this.size != null) {
      data['size'] = this.size?.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? storeId;
  String? shortDesc;
  String? image;
  int? isLiked;
  dynamic originalPrice;
  dynamic price;
  String? currency;

  Product(
      {this.id,
      this.name,
      this.storeId,
      this.shortDesc,
      this.image,
      this.isLiked,
      this.originalPrice,
      this.price,
      this.currency});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['store_id'];
    shortDesc = json['short_desc'];
    image = json['image'];
    isLiked = json['is_liked'];
    originalPrice = json['original_price'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['short_desc'] = this.shortDesc;
    data['image'] = this.image;
    data['is_liked'] = this.isLiked;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}

class ProductColor {
  int? id;
  String? name;
  String? hexa;

  ProductColor({this.id, this.name, this.hexa});

  ProductColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexa = json['hexa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hexa'] = this.hexa;
    return data;
  }
}

class ProductSize {
  int? id;
  String? name;
  String? hexa;

  ProductSize({this.id, this.name, this.hexa});

  ProductSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexa = json['hexa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hexa'] = this.hexa;
    return data;
  }
}
