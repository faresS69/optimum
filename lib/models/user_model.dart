class AppUser {
  String uid;
  String email;
  String password;
  String name;
  String image;

  AppUser(
      {required this.email,
      required this.uid,
      required this.password,
      required this.name,
      required this.image});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid' : uid,
      'email': email,
      'password': password,
      'name': name,
      'image': image,
    };
  }
}
AppUser currentUserInfo = AppUser(
  uid: '',
  name: '',
  email: '',
  image: '',
  password: '',
);