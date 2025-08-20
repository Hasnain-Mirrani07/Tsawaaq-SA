import 'package:tasawaaq/features/home/home_response.dart';

class SearchPostResponse {
  bool? status;
  String? message;
  Data? data;
  Pagination? pagination;

  var error;
  String? errorMsg;

  SearchPostResponse.makeError({this.error, this.errorMsg});
  SearchPostResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  SearchPostResponse({this.status, this.message, this.data, this.pagination});

  SearchPostResponse.fromJson(Map<String, dynamic> json) {
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
  int? total;
  List<Products>? products;

  Data({this.total, this.products,});

  Data.fromJson(Map<String, dynamic> json) {
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
