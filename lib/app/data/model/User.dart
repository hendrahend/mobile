// class User {
//   final String accessToken;
//   final String refreshToken;
//   final int id;
//   final String username;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String gender;
//   final String image;
//   final String name;

//   User({
//     this.accessToken = "",
//     this.refreshToken = "",
//     this.id = 0,
//     this.username = "",
//     this.email = "",
//     this.firstName = "",
//     this.lastName = "",
//     this.gender = "",
//     this.image = "",
//     this.name = "",
//   });
// }

class User {
  String name;
  String email;
  String image;

  User({this.name = '', this.email = '', this.image = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
