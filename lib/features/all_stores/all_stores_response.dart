class StoresResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  StoresResponse.makeError({this.error, this.errorMsg});
  StoresResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  StoresResponse({this.status, this.message, this.data});

  StoresResponse.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? categories;
  List<Stores>? stores;

  Data({this.categories, this.stores});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(new Categories.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores?.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  String? logo;
  String? address;
  List<Mall>? mall;

  Stores({this.id, this.name, this.logo, this.address, this.mall});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    if (json['mall'] != null) {
      mall = <Mall>[];
      json['mall'].forEach((v) {
        mall?.add(new Mall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['address'] = this.address;
    if (this.mall != null) {
      data['mall'] = this.mall?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mall {
  int? id;
  String? name;
  String? background;
  String? logo;
  String? desc;
  String? address;
  String? websiteUrl;
  double? lat;
  double? lng;

  Mall(
      {this.id,
      this.name,
      this.background,
      this.logo,
      this.desc,
      this.address,
      this.websiteUrl,
      this.lat,
      this.lng});

  Mall.fromJson(Map<String, dynamic> json) {
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
