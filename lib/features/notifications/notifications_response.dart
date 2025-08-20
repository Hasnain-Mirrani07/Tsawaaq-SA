// import 'package:tasawaaq/features/home/home_response.dart';
//
// class NotificationsResponse {
//   bool? status;
//   String? message;
//   Data? data;
//   Pagination? pagination;
//
//   var error;
//   String? errorMsg;
//
//   NotificationsResponse.makeError({this.error, this.errorMsg});
//   NotificationsResponse.fromJsonError({
//     required Map<String, dynamic> json,
//     this.error,
//   }) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   NotificationsResponse(
//       {this.status, this.message, this.data, this.pagination});
//
//   NotificationsResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     pagination = json['pagination'] != null
//         ? new Pagination.fromJson(json['pagination'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? title;
//   String? min;
//   String? max;
//   int? total;
//   List<Products>? products;
//
//   Data({this.title, this.total, this.products, this.max, this.min});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     min = json['min'];
//     max = json['max'];
//     title = json['title'];
//     total = json['total'];
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(new Products.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['min'] = this.min;
//     data['max'] = this.max;
//     data['title'] = this.title;
//     data['total'] = this.total;
//     if (this.products != null) {
//       data['products'] = this.products!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Pagination {
//   int? total;
//   int? lastPage;
//   int? perPage;
//   int? currentPage;
//
//   Pagination({this.total, this.lastPage, this.perPage, this.currentPage});
//
//   Pagination.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     lastPage = json['lastPage'];
//     perPage = json['perPage'];
//     currentPage = json['currentPage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total'] = this.total;
//     data['lastPage'] = this.lastPage;
//     data['perPage'] = this.perPage;
//     data['currentPage'] = this.currentPage;
//     return data;
//   }
// }


class NotificationsResponse {
  bool? status;
  String? message;
  List<Data>? data;
  Pagination? pagination;


    var error;
  String? errorMsg;

  NotificationsResponse.makeError({this.error, this.errorMsg});
  NotificationsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  NotificationsResponse(
      {this.status, this.message, this.data, this.pagination});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  User? user;
  String? model;
  int? modelId;
  String? title;
  String? message;

  Data(
      {this.id, this.user, this.model, this.modelId, this.title, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    model = json['model'];
    modelId = json['model_id'];
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['model'] = this.model;
    data['model_id'] = this.modelId;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
