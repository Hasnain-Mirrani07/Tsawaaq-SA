import 'package:tasawaaq/features/home/home_response.dart';

class SearchGetResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  SearchGetResponse.makeError({this.error, this.errorMsg});
  SearchGetResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  SearchGetResponse({this.status, this.message, this.data});

  SearchGetResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic total;
  bool? hasRecent;
  List<Products>? products;
  List<Products>? recectSearchs;
  List<Products>? popularSearchs;

  Data({this.products, this.recectSearchs,this.total,this.hasRecent,});

  Data.fromJson(Map<String, dynamic> json) {
   total = json['total'];
   hasRecent = json['has_recent'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['recectSearchs'] != null) {
      recectSearchs = <Products>[];
      json['recectSearchs'].forEach((v) {
        recectSearchs!.add(new Products.fromJson(v));
      });
    }
    if (json['popularSearchs'] != null) {
      popularSearchs = <Products>[];
      json['popularSearchs'].forEach((v) {
        popularSearchs!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  data['total'] = this.total;
  data['has_recent'] = this.hasRecent;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.recectSearchs != null) {
      data['recectSearchs'] =
          this.recectSearchs!.map((v) => v.toJson()).toList();
    }
    if (this.popularSearchs != null) {
      data['popularSearchs'] =
          this.popularSearchs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


