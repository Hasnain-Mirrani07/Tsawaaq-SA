
class ChangePasswordResponse {
  bool? status;
  String? message;

  var error;
  String? errorMsg;

  ChangePasswordResponse.makeError({this.error, this.errorMsg});
  ChangePasswordResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ChangePasswordResponse({this.status, this.message,});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
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
