class IntroResponse {
  bool? status;
  String? message;
  List<Data>? data;

  var error;
  String? errorMsg;

  IntroResponse.makeError({this.error, this.errorMsg});
  IntroResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  IntroResponse({this.status, this.message, this.data});

  IntroResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? desc;
  String? image;

  Data({this.id, this.desc, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}
