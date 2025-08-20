class AddressesRequest {
  String? method;
  String? name;
  String? email;
  String? phone;
  String? area;
  String? block;
  String? street;
  String? building;
  String? floor;
  String? avenue;
  String? notes;

  AddressesRequest({
     this.name,
     this.method,
     this.email,
     this.phone,
     this.area,
     this.block,
     this.street,
     this.building,
     this.floor,
     this.avenue,
     this.notes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_method'] = this.method;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['area'] = this.area;
    data['block'] = this.block;
    data['street_no'] = this.street;
    data['building_no'] = this.building;
    data['floor_no'] = this.floor;
    data['avenue'] = this.avenue;
    data['text_instructions'] = this.notes;
    return data;
  }
}
