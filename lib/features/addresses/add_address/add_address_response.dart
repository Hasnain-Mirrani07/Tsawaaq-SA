import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';

class AddAddressResponse {
  bool? status;
  String? message;
  Address? data;

  var error;
  String? errorMsg;

  AddAddressResponse.makeError({this.error, this.errorMsg});
  AddAddressResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AddAddressResponse({this.status, this.message, this.data});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Address.fromJson(json['data']) : null;
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

// class Data {
//   int? id;
//   String? name;
//   User? user;
//   Area? area;
//   String? streetNo;
//   String? buildingNo;
//   String? block;
//   String? floorNo;
//   String? avenue;
//   String? textInstructions;
//
//   Data(
//       {this.id,
//         this.name,
//         this.user,
//         this.area,
//         this.streetNo,
//         this.buildingNo,
//         this.block,
//         this.floorNo,
//         this.avenue,
//         this.textInstructions});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     area = json['area'] != null ? new Area.fromJson(json['area']) : null;
//     streetNo = json['street_no'];
//     buildingNo = json['building_no'];
//     block = json['block'];
//     floorNo = json['floor_no'];
//     avenue = json['avenue'];
//     textInstructions = json['text_instructions'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.area != null) {
//       data['area'] = this.area!.toJson();
//     }
//     data['street_no'] = this.streetNo;
//     data['building_no'] = this.buildingNo;
//     data['block'] = this.block;
//     data['floor_no'] = this.floorNo;
//     data['avenue'] = this.avenue;
//     data['text_instructions'] = this.textInstructions;
//     return data;
//   }
// }

class User {
  int? id;
  String? name;
  String? phone;
  String? email;

  User({this.id, this.name, this.phone, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class Area {
  int? id;
  String? name;

  Area({this.id, this.name});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Area &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
