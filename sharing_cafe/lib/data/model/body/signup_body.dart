class SignUpBody {
  String? phone;
  String? email;
  String? password;

  SignUpBody({ this.phone, this.email='', this.password});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
