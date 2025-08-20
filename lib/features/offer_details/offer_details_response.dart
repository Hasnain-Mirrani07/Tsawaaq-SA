class OfferDetailsResponse {
  bool? status;
  String? message;
  OfferDetailsData? data;

  var error;
  String? errorMsg;

  OfferDetailsResponse.makeError({this.error, this.errorMsg});
  OfferDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  OfferDetailsResponse({this.status, this.message, this.data});

  OfferDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new OfferDetailsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class OfferDetailsData {
  dynamic id;
  String? title;
  String? text;
  String? offerImage;
  String? brandImage;
  dynamic amount;
  String? qrImage;
  String? codeNo;
  String? address;

  OfferDetailsData(
      {this.id,
      this.title,
      this.text,
      this.offerImage,
      this.brandImage,
      this.amount,
      this.qrImage,
      this.codeNo,
      this.address});

  OfferDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    offerImage = json['offer_image'];
    brandImage = json['brand_image'];
    amount = json['amount'];
    qrImage = json['qr_image'];
    codeNo = json['code_no'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['offer_image'] = this.offerImage;
    data['brand_image'] = this.brandImage;
    data['amount'] = this.amount;
    data['qr_image'] = this.qrImage;
    data['code_no'] = this.codeNo;
    data['address'] = this.address;
    return data;
  }
}
