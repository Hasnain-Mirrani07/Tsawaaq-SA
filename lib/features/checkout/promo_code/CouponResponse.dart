class CouponResponse {
  bool? status;
  String? message;
  CouponData? data;

  var error;
  String? errorMsg;

  CouponResponse.makeError({this.error, this.errorMsg});
  CouponResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  CouponResponse({this.status, this.message, this.data});

  CouponResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CouponData.fromJson(json['data']) : null;
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

class CouponData {
  dynamic coponId;
  dynamic discount;
  dynamic total;

  CouponData({this.coponId, this.discount, this.total});

  CouponData.fromJson(Map<String, dynamic> json) {
    coponId = json['copon_id'];
    discount = json['discount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['copon_id'] = this.coponId;
    data['discount'] = this.discount;
    data['total'] = this.total;
    return data;
  }
}
