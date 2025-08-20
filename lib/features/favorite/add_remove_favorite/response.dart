class AddRemoveFavoriteResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  AddRemoveFavoriteResponse.makeError({this.error, this.errorMsg});
  AddRemoveFavoriteResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AddRemoveFavoriteResponse({this.status, this.message, this.data});

  AddRemoveFavoriteResponse.fromJson(Map<String, dynamic> json) {
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
  int? like;

  Data({this.like});

  Data.fromJson(Map<String, dynamic> json) {
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['like'] = this.like;
    return data;
  }
}
