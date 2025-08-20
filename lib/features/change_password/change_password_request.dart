class ChangePasswordRequest {
  String currentPassword;
  String password;
  String passwordConfirmation;

  ChangePasswordRequest({required this.currentPassword, required this.password,required this.passwordConfirmation});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_password'] = this.currentPassword;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
