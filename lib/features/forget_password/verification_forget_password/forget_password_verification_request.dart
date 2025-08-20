class ForgetPasswordVerificationRequest {
  String? code, phone;

  ForgetPasswordVerificationRequest({this.code, this.phone});

  ForgetPasswordVerificationRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['phone'] = this.phone;
    return data;
  }
}
