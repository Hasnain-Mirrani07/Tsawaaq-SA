import 'package:tasawaaq/features/home/home_response.dart';

class ProductListResponse {
  bool? status;
  String? message;
  Data? data;
  Pagination? pagination;

  var error;
  String? errorMsg;

  ProductListResponse.makeError({this.error, this.errorMsg});
  ProductListResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ProductListResponse({this.status, this.message, this.data, this.pagination});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  Store? store;
  List<Brands>? brands;
  String? title;
  dynamic min;
  dynamic max;
  int? status;
  int? total;
  List<Products>? products;

  Data(
      {this.store,
      this.brands,
      this.title,
      this.total,
      this.products,
      this.min,
      this.max,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
    min = json['min'];
    status = json['status'];
    max = json['max'];
    title = json['title'];
    total = json['total'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    data['min'] = this.min;
    data['status'] = this.status;
    data['max'] = this.max;
    data['title'] = this.title;
    data['total'] = this.total;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? logo;
  String? address;
  List<Mall>? mall;

  Store({this.id, this.name, this.logo, this.address, this.mall});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    if (json['mall'] != null) {
      mall = <Mall>[];
      json['mall'].forEach((v) {
        mall!.add(new Mall.fromJson(v));
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
      data['mall'] = this.mall!.map((v) => v.toJson()).toList();
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

class Brands {
  int? id;
  String? name;
  String? image;

  Brands({this.id, this.name, this.image});

  Brands.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? total;
  int? lastPage;
  int? perPage;
  int? currentPage;

  Pagination({this.total, this.lastPage, this.perPage, this.currentPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lastPage = json['lastPage'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['lastPage'] = this.lastPage;
    data['perPage'] = this.perPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}
