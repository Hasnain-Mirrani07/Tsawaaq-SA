class PaymentResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  PaymentResponse.makeError({this.error, this.errorMsg});
  PaymentResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  PaymentResponse({this.status, this.message, this.data});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic items;
  dynamic total;
  String? currency;
  String? paymentUrl;

  Data({this.orderId, this.items, this.total, this.currency, this.paymentUrl});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    items = json['items'];
    total = json['total'];
    currency = json['currency'];
    paymentUrl = json['paymentUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['items'] = this.items;
    data['total'] = this.total;
    data['currency'] = this.currency;
    data['paymentUrl'] = this.paymentUrl;

    return data;
  }
}
