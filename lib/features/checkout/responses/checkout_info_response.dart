import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart' hide User;
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';

class CheckoutInfoResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  CheckoutInfoResponse.makeError({this.error, this.errorMsg});
  CheckoutInfoResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  CheckoutInfoResponse({this.status, this.message, this.data});

  CheckoutInfoResponse.fromJson(Map<String, dynamic> json) {
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
  String? returnStatus;
  dynamic count;
  List<CheckoutInfoCartProduct>? cart;
  List<Addresses>? addresses;

  Data(
      {this.subtotal,
      this.discount,
      this.delivery,
      this.total,
      this.currency,
      this.returnStatus,
      this.count,
      this.cart,
      this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal_formatted'];
    discount = json['discount'];
    returnStatus = json['return'];
    delivery = json['delivery'];
    total = json['total'];
    currency = json['currency'];
    count = json['count'];
    if (json['cart'] != null) {
      cart = <CheckoutInfoCartProduct>[];
      json['cart'].forEach((v) {
        cart?.add(new CheckoutInfoCartProduct.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses?.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal_formatted'] = this.subtotal;
    data['discount'] = this.discount;
    data['return'] = this.returnStatus;
    data['delivery'] = this.delivery;
    data['total'] = this.total;
    data['currency'] = this.currency;
    data['count'] = this.count;
    if (this.cart != null) {
      data['cart'] = this.cart?.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckoutInfoCartProduct {
  int? cartId;
  Product? product;
  dynamic count;
  dynamic totalPrice;
  ProductColor? color;
  ProductSize? size;
  dynamic quantity;

  CheckoutInfoCartProduct(
      {this.cartId,
      this.product,
      this.count,
      this.totalPrice,
      this.color,
      this.size,
      this.quantity});

  CheckoutInfoCartProduct.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    count = json['count'];
    totalPrice = json['total_price'];
    color =
        json['color'] != null ? new ProductColor.fromJson(json['color']) : null;
    size = json['size'] != null ? new ProductSize.fromJson(json['size']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
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
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  dynamic id;
  String? name;
  dynamic storeId;
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
  dynamic id;
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

class Addresses {
  dynamic id;
  String? name;
  String? fullAddress;
  Address? address;

  Addresses({this.id, this.name, this.fullAddress, this.address});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullAddress = json['full_address'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['full_address'] = this.fullAddress;
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    return data;
  }
}

class Address {
  dynamic id;
  String? name;
  User? user;
  Area? area;
  String? streetNo;
  String? buildingNo;
  String? block;
  String? floorNo;
  String? avenue;
  String? textInstructions;

  Address(
      {this.id,
      this.name,
      this.area,
      this.streetNo,
      this.buildingNo,
      this.block,
      this.floorNo,
      this.avenue,
      this.user,
      this.textInstructions});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    streetNo = json['street_no'];
    buildingNo = json['building_no'];
    block = json['block'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;

    floorNo = json['floor_no'];
    avenue = json['avenue'];
    textInstructions = json['text_instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.area != null) {
      data['area'] = this.area?.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['street_no'] = this.streetNo;
    data['building_no'] = this.buildingNo;
    data['block'] = this.block;
    data['floor_no'] = this.floorNo;
    data['avenue'] = this.avenue;
    data['text_instructions'] = this.textInstructions;
    return data;
  }
}

// class Area {
//   dynamic id;
//   String? name;
//
//   Area({this.id, this.name});
//
//   Area.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }
