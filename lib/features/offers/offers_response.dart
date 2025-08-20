class OffersResponse {
  bool? status;
  String? message;
  List<Data>? data;

  var error;
  String? errorMsg;

  OffersResponse.makeError({this.error, this.errorMsg});
  OffersResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  OffersResponse({this.status, this.message, this.data});

  OffersResponse.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  String? title;
  String? offerImage;
  dynamic discountPercentage;

  Data({this.id, this.title, this.offerImage, this.discountPercentage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    offerImage = json['offer_image'];
    discountPercentage = json['discount_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['offer_image'] = this.offerImage;
    data['discount_percentage'] = this.discountPercentage;
    return data;
  }
}
