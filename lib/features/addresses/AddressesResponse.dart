// class AddressesResponse {
//   int? status;
//   String? message;
//   Data? data;
//
//   var error;
//   String? errorMsg;
//
//   AddressesResponse.makeError({this.error, this.errorMsg});
//   AddressesResponse.fromJsonError({
//     required Map<String, dynamic> json,
//     this.error,
//   }) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   AddressesResponse({this.status, this.message, this.data});
//
//   AddressesResponse.fromJson(Map<String, dynamic> json) {
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
//   List<Addresses>? addresses;
//
//   Data({this.addresses});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['addresses'] != null) {
//       addresses = <Addresses>[];
//       json['addresses'].forEach((v) {
//         addresses!.add(new Addresses.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.addresses != null) {
//       data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Addresses {
//   int? id;
//   String? title;
//   String? governate;
//   String? city;
//   String? block;
//   String? jada;
//   String? street;
//   String? building;
//   String? floor;
//   String? flat;
//   String? notes;
//   String? lat;
//   String? lng;
//   String? governateId;
//   String? cityId;
//
//   Addresses(
//       {this.id,
//         this.title,
//         this.governate,
//         this.city,
//         this.block,
//         this.jada,
//         this.street,
//         this.building,
//         this.floor,
//         this.flat,
//         this.notes,
//         this.lat,
//         this.lng,
//         this.governateId,
//         this.cityId});
//
//   Addresses.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     governate = json['governate'];
//     city = json['city'];
//     block = json['block'];
//     jada = json['jada'];
//     street = json['street'];
//     building = json['building'];
//     floor = json['floor'];
//     flat = json['flat'];
//     notes = json['notes'];
//     lat = json['lat'];
//     lng = json['lng'];
//     governateId = json['governate_id'];
//     cityId = json['city_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['governate'] = this.governate;
//     data['city'] = this.city;
//     data['block'] = this.block;
//     data['jada'] = this.jada;
//     data['street'] = this.street;
//     data['building'] = this.building;
//     data['floor'] = this.floor;
//     data['flat'] = this.flat;
//     data['notes'] = this.notes;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['governate_id'] = this.governateId;
//     data['city_id'] = this.cityId;
//     return data;
//   }
// }

/////////////////////////////////////////////////

// class AddressesResponse {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//     var error;
//   String? errorMsg;
//
//   AddressesResponse.makeError({this.error, this.errorMsg});
//   AddressesResponse.fromJsonError({
//     required Map<String, dynamic> json,
//     this.error,
//   }) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   AddressesResponse({this.status, this.message, this.data});
//
//   AddressesResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? fullAddress;
//   Address? address;
//
//   Data({this.id, this.name, this.fullAddress, this.address});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     fullAddress = json['full_address'];
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['full_address'] = this.fullAddress;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     return data;
//   }
// }
//
// class Address {
//   int? id;
//   String? name;
//   Area? area;
//   String? streetNo;
//   String? buildingNo;
//   String? block;
//   String? floorNo;
//   String? avenue;
//   String? textInstructions;
//
//   Address(
//       {this.id,
//         this.name,
//         this.area,
//         this.streetNo,
//         this.buildingNo,
//         this.block,
//         this.floorNo,
//         this.avenue,
//         this.textInstructions});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
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

// class Area {
//   int? id;
//   String? name;
//
//   Area({this.id, this.name});
//
//   Area.fromJson(Map<String, dynamic> json) {
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
