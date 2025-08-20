// import 'package:fawtara/shared/domain/user.dart';

// class VerificationResponse {
//   int? status;
//   String? message;
//   Data? data;

//   VerificationResponse({this.status, this.message, this.data});

//   VerificationResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   User user;

//   Data({this.user});

//   Data.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     return data;
//   }
// }

// // class User {
// //   int id;
// //   String name;
// //   String email;
// //   String phone;
// //   String image;
// //   int invoicesCount;
// //   String invoicesAmount;
// //   String authorization;
// //   int notifications;

// //   User(
// //       {this.id,
// //       this.name,
// //       this.email,
// //       this.phone,
// //       this.image,
// //       this.invoicesCount,
// //       this.invoicesAmount,
// //       this.authorization,
// //       this.notifications});

// //   User.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //     email = json['email'];
// //     phone = json['phone'];
// //     image = json['image'];
// //     invoicesCount = json['invoices_count'];
// //     invoicesAmount = json['invoices_amount'];
// //     authorization = json['authorization'];
// //     notifications = json['notifications'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['name'] = this.name;
// //     data['email'] = this.email;
// //     data['phone'] = this.phone;
// //     data['image'] = this.image;
// //     data['invoices_count'] = this.invoicesCount;
// //     data['invoices_amount'] = this.invoicesAmount;
// //     data['authorization'] = this.authorization;
// //     data['notifications'] = this.notifications;
// //     return data;
// //   }
// // }
