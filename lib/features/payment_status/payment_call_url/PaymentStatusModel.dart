// class PaymentStatusModel {
//   int? status;
//   String? message;
//   Data? data;
//
//   PaymentStatusModel({this.status, this.message, this.data});
//
//   PaymentStatusModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? orderId;
//   String? total;
//   String? paymentLink;
//
//   Data({this.orderId, this.total, this.paymentLink});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     total = json['total'];
//     paymentLink = json['payment_link'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_id'] = this.orderId;
//     data['total'] = this.total;
//     data['payment_link'] = this.paymentLink;
//     return data;
//   }
// }

// class PaymentStatusModel {
//   String? message;
//   PaymentStatusModel({this.message});
//
//
//   PaymentStatusModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// } .