class AboutMallResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  AboutMallResponse.makeError({this.error, this.errorMsg});
  AboutMallResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AboutMallResponse({this.status, this.message, this.data});

  AboutMallResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  int? status;
  String? image;
  String? logo;
  String? description;
  String? address;
  String? website;
  double? lat;
  double? lng;

  Data(
      {this.id,
      this.name,
      this.image,
      this.logo,
      this.description,
      this.address,
      this.website,
      this.lat,
      this.lng});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    image = json['background'];
    logo = json['logo'];
    description = json['desc'];
    address = json['address'];
    website = json['website_url'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['background'] = this.image;
    data['logo'] = this.logo;
    data['desc'] = this.description;
    data['address'] = this.address;
    data['website_url'] = this.website;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
