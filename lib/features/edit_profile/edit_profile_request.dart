class EditProfileRequest {
  String? name;
  String? phone;
  String? email;
  String? birthDate;
  var image;
  String? gender;

  EditProfileRequest(
      {this.name,
      this.phone,
      this.email,
      this.birthDate,
      this.image,
      this.gender});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['birth_date'] = this.birthDate;
    data['image'] = this.image;
    data['gender'] = this.gender;
    return data;
  }
}
