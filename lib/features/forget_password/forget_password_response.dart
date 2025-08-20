class ForgetPasswordResponse {
  bool? status;
  String? message;
  Data? data;
  var error;
  String? errorMsg;

  ForgetPasswordResponse.makeError({this.error, this.errorMsg});
  ForgetPasswordResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  ForgetPasswordResponse({this.status, this.message, this.data});

  ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  int? code;

  Data({this.phone, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['code'] = this.code;
    return data;
  }
}
