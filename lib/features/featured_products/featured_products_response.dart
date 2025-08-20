import 'package:tasawaaq/features/home/home_response.dart';

class FeaturedProductsResponse {
  bool? status;
  String? message;
  Data? data;
  Pagination? pagination;

  var error;
  String? errorMsg;

  FeaturedProductsResponse.makeError({this.error, this.errorMsg});
  FeaturedProductsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  FeaturedProductsResponse(
      {this.status, this.message, this.data, this.pagination});

  FeaturedProductsResponse.fromJson(Map<String, dynamic> json) {
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
  String? title;
  dynamic min;
  dynamic max;
  int? total;
  List<Products>? products;

  Data({this.title, this.total, this.products, this.max, this.min});

  Data.fromJson(Map<String, dynamic> json) {
    min = json['min'];
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
    data['min'] = this.min;
    data['max'] = this.max;
    data['title'] = this.title;
    data['total'] = this.total;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
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
