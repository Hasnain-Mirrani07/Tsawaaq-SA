/// AddToCartRequest
class AddToCartRequest {
  int? productId;
  int? count;
  int? storeId;
  int? colorId;
  int? sizeId;

  AddToCartRequest(
      {this.productId, this.count, this.storeId, this.colorId, this.sizeId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['store_id'] = this.storeId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    return data;
  }
}

/// RemoveFromCartRequest
class RemoveFromCartRequest {
  int? cartId;

  RemoveFromCartRequest({this.cartId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    return data;
  }
}
