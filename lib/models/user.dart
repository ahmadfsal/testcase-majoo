class User {
  final String email;
  final String? userName;
  final String password;

  User({required this.email, this.userName, required this.password});

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        userName = json['username'];

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'username': userName};
}
