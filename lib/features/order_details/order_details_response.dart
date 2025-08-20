// class OrderDetailsResponse {
//   bool? status;
//   String? message;
//   Data? data;
//
//   var error;
//   String? errorMsg;
//
//   OrderDetailsResponse.makeError({this.error, this.errorMsg});
//   OrderDetailsResponse.fromJsonError({
//     required Map<String, dynamic> json,
//     this.error,
//   }) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   OrderDetailsResponse({this.status, this.message, this.data});
//
//   OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? user;
//   String? address;
//   String? status;
//   String? createdAt;
//   String? createdTime;
//   List<Items>? items;
//   Payment? payment;
//   String? currency;
//
//   Data(
//       {this.id,
//         this.user,
//         this.address,
//         this.status,
//         this.createdAt,
//         this.createdTime,
//         this.items,
//         this.payment,
//         this.currency});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'];
//     address = json['address'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     createdTime = json['created_time'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//     payment =
//     json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
//     currency = json['currency'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user'] = this.user;
//     data['address'] = this.address;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['created_time'] = this.createdTime;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     if (this.payment != null) {
//       data['payment'] = this.payment!.toJson();
//     }
//     data['currency'] = this.currency;
//     return data;
//   }
// }
//
// class Items {
//   int? id;
//   String? name;
//   dynamic price;
//   String? image;
//   String? colorHexa;
//   String? color;
//   String? size;
//   int? count;
//
//   Items(
//       {this.id,
//         this.name,
//         this.price,
//         this.image,
//         this.colorHexa,
//         this.color,
//         this.size,
//         this.count});
//
//   Items.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     image = json['image'];
//     colorHexa = json['color_hexa'];
//     color = json['color'];
//     size = json['size'];
//     count = json['count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['image'] = this.image;
//     data['color_hexa'] = this.colorHexa;
//     data['color'] = this.color;
//     data['size'] = this.size;
//     data['count'] = this.count;
//     return data;
//   }
// }
//
// class Payment {
//   String? paymentMethod;
//   dynamic subtotal;
//   dynamic delivery;
//   dynamic discount;
//   dynamic total;
//
//   Payment(
//       {this.paymentMethod,
//         this.subtotal,
//         this.delivery,
//         this.discount,
//         this.total});
//
//   Payment.fromJson(Map<String, dynamic> json) {
//     paymentMethod = json['payment_method'];
//     subtotal = json['subtotal_formatted'];
//     delivery = json['delivery'];
//     discount = json['discount'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['payment_method'] = this.paymentMethod;
//     data['subtotal_formatted'] = this.subtotal;
//     data['delivery'] = this.delivery;
//     data['discount'] = this.discount;
//     data['total'] = this.total;
//     return data;
//   }
// }

class OrderDetailsResponse {
  bool? status;
  String? message;
  Data? data;

    var error;
  String? errorMsg;

  OrderDetailsResponse.makeError({this.error, this.errorMsg});
  OrderDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  OrderDetailsResponse({this.status, this.message, this.data});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? user;
  String? address;
  String? status;
  String? createdAt;
  String? createdTime;
  List<Items>? items;
  int? canReorder;
  Payment? payment;
  String? currency;

  Data(
      {this.id,
        this.user,
        this.address,
        this.status,
        this.createdAt,
        this.createdTime,
        this.items,
        this.canReorder,
        this.payment,
        this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    createdTime = json['created_time'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    canReorder = json['can_reorder'];
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['created_time'] = this.createdTime;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['can_reorder'] = this.canReorder;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    data['currency'] = this.currency;
    return data;
  }
}

class Items {
  int? id;
  String? name;
  dynamic price;
  String? image;
  String? colorHexa;
  String? color;
  String? size;
  int? count;

  Items(
      {this.id,
        this.name,
        this.price,
        this.image,
        this.colorHexa,
        this.color,
        this.size,
        this.count});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    colorHexa = json['color_hexa'];
    color = json['color'];
    size = json['size'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['color_hexa'] = this.colorHexa;
    data['color'] = this.color;
    data['size'] = this.size;
    data['count'] = this.count;
    return data;
  }
}

class Payment {
  String? paymentMethod;
  dynamic subtotal;
  dynamic delivery;
  dynamic discount;
  dynamic total;

  Payment(
      {this.paymentMethod,
        this.subtotal,
        this.delivery,
        this.discount,
        this.total});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    subtotal = json['subtotal_formatted'];
    delivery = json['delivery'];
    discount = json['discount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['subtotal_formatted'] = this.subtotal;
    data['delivery'] = this.delivery;
    data['discount'] = this.discount;
    data['total'] = this.total;
    return data;
  }
}
