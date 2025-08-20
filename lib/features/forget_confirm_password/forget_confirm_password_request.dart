class ForgetPasswordConfirmationRequest {
  String userId,password;
  ForgetPasswordConfirmationRequest({
    required this.userId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['password'] = this.password;
    return data;
  }
}
