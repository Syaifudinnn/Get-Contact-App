class LoginResponse {
  Data? data;

  LoginResponse({this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class Data {
  String? email;
  String? name;
  String? token;

  Data({this.email, this.name, this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'token': token,
    };
  }
}
