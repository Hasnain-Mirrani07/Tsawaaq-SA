typedef FromJsonCallback<T> = T Function(Map<String, dynamic> json);
typedef ToJsonCallback<T> = Map<String, dynamic> Function();

class ApiResponse<T> {
  int? status;
  String? message;
  // bool isList;
  T? dataObj;
  // List<T> dataList;
  FromJsonCallback<T>? fromJsonCallback;
  ToJsonCallback<T>? toJsonCallback;
  var error;
  String? errorMsg;

  ApiResponse({
    this.status,
    this.message,
    this.dataObj,
    // this.dataList,
    // this.isList = false,
  });

  ApiResponse.makeError({this.error, this.errorMsg});
  // ApiResponse.unknownError(this.error);

  ApiResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  ApiResponse.fromJson({
    required Map<String, dynamic> json,
    // this.isList = false,
    this.fromJsonCallback,
    this.toJsonCallback,
  }) {
    status = json['status'];
    message = json['message'];

    // if (isList) {
    //   if (json['data'] != null) {
    //     dataList = List<T>();
    //     json['data'].forEach((v) {
    //       dataList.add(fromJsonCallback(v));
    //     });
    //   }
    // } else {
    dataObj = json['data'] != null ? fromJsonCallback!(json['data']) : null;
    // }
  }

  Map<String, dynamic> toJson(
      //   {
      //   bool isList = false,
      // }
      ) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;

    // if (isList) {
    //   if (this.dataList != null) {
    //     data['data'] = this.dataList.map((v) => this.toJsonCallback()).toList();
    //   }
    // } else {
    if (this.dataObj != null) {
      // data['data'] = this.dataObj.toJson();
      data['data'] = this.toJsonCallback!();
    }
    // }

    return data;
  }
}
