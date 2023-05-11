class UserModel {
  String? email;
  String? name;
  String? password;
  String? role;
  UserModel({
    this.email,
    this.name,
    this.password,
    this.role,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'role': role,
    };
  }
}
