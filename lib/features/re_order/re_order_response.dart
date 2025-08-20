class ReOrderResponse {
  bool? status;
  String? message;
  // Data? data;

  var error;
  String? errorMsg;

  ReOrderResponse.makeError({this.error, this.errorMsg});
  ReOrderResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ReOrderResponse({this.status, this.message});

  ReOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    // if (this.data != null) {
    //   data['data'] = this.data?.toJson();
    // }
    return data;
  }
}

