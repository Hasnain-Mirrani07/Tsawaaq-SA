class User {
  int? id;
  int? status;
  bool? phoneVerified;
  String? image;
  String? name;
  String? phone;
  String? email;
  String? dateOfBirth;
  String? accessToken;
  String? gender;

  User({
    this.id,
    this.status,
    this.phoneVerified,
    this.image,
    this.name,
    this.phone,
    this.email,
    this.dateOfBirth,
    this.accessToken,
    this.gender,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    phoneVerified = json['phone_verified'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    accessToken = json['access_token'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['phone_verified'] = this.phoneVerified;
    data['image'] = this.image;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['access_token'] = this.accessToken;
    data['gender'] = this.accessToken;
    return data;
  }
}
