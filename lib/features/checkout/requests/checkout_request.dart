class PaymentRequest {
  final String addressId;
  final String offerId;

  /// cash , knet , credit
  final String paymentMethod;

  PaymentRequest(
      {required this.addressId,
      this.offerId = '',
      required this.paymentMethod});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['offer_id'] = this.offerId;
    data['payment_method'] = this.paymentMethod;

    return data;
  }
}
