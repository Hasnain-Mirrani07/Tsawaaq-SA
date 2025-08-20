class ProductDetailsResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  ProductDetailsResponse.makeError({this.error, this.errorMsg});
  ProductDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ProductDetailsResponse({this.status, this.message, this.data});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? shortDesc;
  String? details;
  dynamic price;
  dynamic originalPrice;
  dynamic isOffered;
  dynamic isLiked;
  List<String>? imagesOfProduct;
  String? currency;

  List<Options>? options;
  int? stocks;

  Data(
      {this.id,
      this.name,
      this.shortDesc,
      this.details,
      this.price,
      this.currency,
      this.originalPrice,
      this.isOffered,
      this.isLiked,
      this.imagesOfProduct,
      this.options,
      this.stocks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDesc = json['short_desc'];
    details = json['details'];
    price = json['price'];
    currency = json['currency'];
    originalPrice = json['original_price'];
    isOffered = json['is_offered'];
    isLiked = json['is_liked'];
    imagesOfProduct = json['images_of_product'].cast<String>();
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options?.add(new Options.fromJson(v));
      });
    }
    stocks = json['stocks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_desc'] = this.shortDesc;
    data['details'] = this.details;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['original_price'] = this.originalPrice;
    data['is_offered'] = this.isOffered;
    data['is_liked'] = this.isLiked;
    data['images_of_product'] = this.imagesOfProduct;
    if (this.options != null) {
      data['options'] = this.options?.map((v) => v.toJson()).toList();
    }
    data['stocks'] = this.stocks;
    return data;
  }
}

class Options {
  int? id;
  String? name;
  String? hexa;
  List<Sizes>? sizes;

  Options({this.id, this.name, this.hexa, this.sizes});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexa = json['hexa'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes?.add(new Sizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hexa'] = this.hexa;
    if (this.sizes != null) {
      data['sizes'] = this.sizes?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Sizes {
//   int? id;
//   String? name;
//   int? quantity;
//   String? price;
//
//   Sizes({this.id, this.name, this.quantity, this.price});
//
//   Sizes.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     quantity = json['quantity'];
//     price = json['price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     return data;
//   }
// }

class Sizes {
  int? id;
  String? name;
  int? quantity;
  dynamic price;
  dynamic originalPrice;

  Sizes({this.id, this.name, this.quantity, this.price, this.originalPrice});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    originalPrice = json['original_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['original_price'] = this.originalPrice;
    return data;
  }
}