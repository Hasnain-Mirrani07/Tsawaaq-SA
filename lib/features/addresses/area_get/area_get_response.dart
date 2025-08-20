import 'package:tasawaaq/features/addresses/AddressesResponse.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';

class AreaResponse {
  bool? status;
  String? message;
  List<Area>? data;


  var error;
  String? errorMsg;

  AreaResponse.makeError({this.error, this.errorMsg});
  AreaResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AreaResponse({this.status, this.message, this.data});

  AreaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Area>[];
      json['data'].forEach((v) {
        data!.add(new Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Data {
//   int? id;
//   String? name;
//
//   Data({this.id, this.name});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }


