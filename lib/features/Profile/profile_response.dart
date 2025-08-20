import 'package:tasawaaq/domain/user.dart';

class ProfileResponse {
  bool? status;
  String? message;
  User? data;

  var error;
  String? errorMsg;

  ProfileResponse.makeError({this.error, this.errorMsg});
  ProfileResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ProfileResponse({this.status, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
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
