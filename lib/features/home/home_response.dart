class HomeResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  HomeResponse.makeError({this.error, this.errorMsg});
  HomeResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  HomeResponse({this.status, this.message, this.data});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Sliders>? sliders;
  List<Malls>? malls;
  List<Stores>? stores;
  List<Sliders>? ads;
  List<Products>? products;
  List<Socials>? socials;

  Data(
      {this.sliders,
        this.malls,
        this.stores,
        this.ads,
        this.products,
        this.socials});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders?.add(new Sliders.fromJson(v));
      });
    }
    if (json['malls'] != null) {
      malls = <Malls>[];
      json['malls'].forEach((v) {
        malls?.add(new Malls.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores?.add(new Stores.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = <Sliders>[];
      json['ads'].forEach((v) {
        ads?.add(new Sliders.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    if (json['socials'] != null) {
      socials = <Socials>[];
      json['socials'].forEach((v) {
        socials?.add(new Socials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliders != null) {
      data['sliders'] = this.sliders?.map((v) => v.toJson()).toList();
    }
    if (this.malls != null) {
      data['malls'] = this.malls?.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores?.map((v) => v.toJson()).toList();
    }
    if (this.ads != null) {
      data['ads'] = this.ads?.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    if (this.socials != null) {
      data['socials'] = this.socials?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Socials {
  String? type;
  String? link;
  String? image;

  Socials({this.type, this.link, this.image});

  Socials.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class Sliders {
  int? id;
  String? link;
  String? image;

  Sliders({this.id, this.link, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class Malls {
  int? id;
  String? name;
  String? logo;

  Malls({this.id, this.name, this.logo});

  Malls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  String? logo;
  String? address;
  List<Mall>? mall;

  Stores({this.id, this.name, this.logo, this.address, this.mall});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    if (json['mall'] != null) {
      mall = <Mall>[];
      json['mall'].forEach((v) {
        mall?.add(new Mall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['address'] = this.address;
    if (this.mall != null) {
      data['mall'] = this.mall?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mall {
  int? id;
  String? name;
  String? background;
  String? logo;
  String? desc;
  String? address;
  String? websiteUrl;
  double? lat;
  double? lng;

  Mall(
      {this.id,
        this.name,
        this.background,
        this.logo,
        this.desc,
        this.address,
        this.websiteUrl,
        this.lat,
        this.lng});

  Mall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    background = json['background'];
    logo = json['logo'];
    desc = json['desc'];
    address = json['address'];
    websiteUrl = json['website_url'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['background'] = this.background;
    data['logo'] = this.logo;
    data['desc'] = this.desc;
    data['address'] = this.address;
    data['website_url'] = this.websiteUrl;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  Store? store;
  String? shortDesc;
  String? image;
  int? isLiked;
  dynamic originalPrice;
  dynamic price;
  String? currency;

  Products(
      {this.id,
        this.name,
        this.store,
        this.shortDesc,
        this.image,
        this.isLiked,
        this.originalPrice,
        this.price,
        this.currency});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    shortDesc = json['short_desc'];
    image = json['image'];
    isLiked = json['is_liked'];
    originalPrice = json['original_price'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['short_desc'] = this.shortDesc;
    data['image'] = this.image;
    data['is_liked'] = this.isLiked;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}

class Store {
  int? id;
  String? name;

  Store({this.id, this.name});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

// class Products {
//   int? id;
//   String? name;
//   int? storeId;
//   String? shortDesc;
//   String? image;
//   int? isLiked;
//   dynamic originalPrice;
//   dynamic price;
//   String? currency;
//
//   Products(
//       {this.id,
//         this.name,
//         this.storeId,
//         this.shortDesc,
//         this.image,
//         this.isLiked,
//         this.originalPrice,
//         this.price,
//         this.currency});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     storeId = json['store_id'];
//     shortDesc = json['short_desc'];
//     image = json['image'];
//     isLiked = json['is_liked'];
//     originalPrice = json['original_price'];
//     price = json['price'];
//     currency = json['currency'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['store_id'] = this.storeId;
//     data['short_desc'] = this.shortDesc;
//     data['image'] = this.image;
//     data['is_liked'] = this.isLiked;
//     data['original_price'] = this.originalPrice;
//     data['price'] = this.price;
//     data['currency'] = this.currency;
//     return data;
//   }
// }
