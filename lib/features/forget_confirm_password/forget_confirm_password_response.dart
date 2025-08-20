class ForgetPasswordConfirmationResponse {
  bool? status;
  String? message;
  var error;
  String? errorMsg;

  ForgetPasswordConfirmationResponse.makeError({this.error, this.errorMsg});
  ForgetPasswordConfirmationResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  ForgetPasswordConfirmationResponse({this.status, this.message});

  ForgetPasswordConfirmationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;

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
