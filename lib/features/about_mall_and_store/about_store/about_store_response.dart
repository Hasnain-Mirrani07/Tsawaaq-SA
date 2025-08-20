class AboutStoreResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  AboutStoreResponse.makeError({this.error, this.errorMsg});
  AboutStoreResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AboutStoreResponse({this.status, this.message, this.data});

  AboutStoreResponse.fromJson(Map<String, dynamic> json) {
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
  int?status;
  int? id;
  String? name;
  List<Malls>? malls;
  String? image;
  String? logo;
  String? description;
  String? website;

  Data(
      {this.id,
      this.name,
      this.malls,
      this.image,
      this.logo,
      this.status,
      this.description,
      this.website});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    if (json['malls'] != null) {
      malls = <Malls>[];
      json['malls'].forEach((v) {
        malls?.add(new Malls.fromJson(v));
      });
    }
    image = json['image'];
    logo = json['logo'];
    description = json['description'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.malls != null) {
      data['malls'] = this.malls?.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['website'] = this.website;
    return data;
  }
}

class Malls {
  int? id;
  String? name;
  String? background;
  String? logo;
  String? desc;
  String? address;
  String? websiteUrl;
  double? lat;
  double? lng;

  Malls(
      {this.id,
      this.name,
      this.background,
      this.logo,
      this.desc,
      this.address,
      this.websiteUrl,
      this.lat,
      this.lng});

  Malls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    background = json['background'];
    logo = json['logo'];
    desc = json['desc'];
    address = json['address'];
    websiteUrl = json['website_url'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['background'] = this.background;
    data['logo'] = this.logo;
    data['desc'] = this.desc;
    data['address'] = this.address;
    data['website_url'] = this.websiteUrl;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
