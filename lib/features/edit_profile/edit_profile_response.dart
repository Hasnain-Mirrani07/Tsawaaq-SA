import 'package:tasawaaq/domain/user.dart';

class EditProfileResponse {
  bool? status;
  String? message;
  User? data;
  int? phoneStatus;

  var error;
  String? errorMsg;

  EditProfileResponse.makeError({this.error, this.errorMsg});
  EditProfileResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
    phoneStatus = json['phoneStatus'];
  }

  EditProfileResponse({this.status, this.message, this.data,this.phoneStatus});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    phoneStatus = json['phoneStatus'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['phoneStatus'] = this.phoneStatus;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}
