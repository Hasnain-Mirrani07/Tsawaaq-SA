class MyOrdersResponse {
  bool? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  MyOrdersResponse.makeError({this.error, this.errorMsg});
  MyOrdersResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  MyOrdersResponse({this.status, this.message, this.data});

  MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Pending>? pending;
  List<Pending>? completed;
  List<Pending>? cancelled;

  Data({this.pending, this.completed, this.cancelled});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Pending>[];
      json['completed'].forEach((v) {
        completed!.add(new Pending.fromJson(v));
      });
    }
    if (json['cancelled'] != null) {
      cancelled = <Pending>[];
      json['cancelled'].forEach((v) {
        cancelled!.add(new Pending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pending {
  int? id;
  String? status;
  String? createdAt;
  String? createdTime;
  dynamic items;
  dynamic total;
  dynamic canReorder;
  String? currency;

  Pending(
      {this.id,
        this.status,
        this.createdAt,
        this.createdTime,
        this.items,
        this.total,
        this.canReorder,
        this.currency});

  Pending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    createdTime = json['created_time'];
    items = json['items'];
    total = json['total'];
    canReorder = json['can_reorder'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['created_time'] = this.createdTime;
    data['items'] = this.items;
    data['total'] = this.total;
    data['can_reorder'] = this.canReorder;
    data['currency'] = this.currency;
    return data;
  }
}
