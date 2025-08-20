class FavoriteResponse {
  bool? status;
  String? message;
  List<Data>? data;

  var error;
  String? errorMsg;

  FavoriteResponse.makeError({this.error, this.errorMsg});
  FavoriteResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  FavoriteResponse({this.status, this.message, this.data});

  FavoriteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? storeId;
  String? shortDesc;
  String? image;
  int? isLiked;
  dynamic originalPrice;
  dynamic price;
  String? currency;

  Data(
      {this.id,
      this.name,
      this.storeId,
      this.shortDesc,
      this.image,
      this.isLiked,
      this.originalPrice,
      this.price,
      this.currency});

  Data.fromJson(Map<String, dynamic> json) {
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
