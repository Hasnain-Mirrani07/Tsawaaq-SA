
class ContactUsPostResponse {
  bool? status;
  String? message;

  var error;
  String? errorMsg;

  ContactUsPostResponse.makeError({this.error, this.errorMsg});
  ContactUsPostResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ContactUsPostResponse({this.status, this.message,});

  ContactUsPostResponse.fromJson(Map<String, dynamic> json) {
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
