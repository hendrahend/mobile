class User {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String name;

  User({
    this.accessToken = "",
    this.refreshToken = "",
    this.id = 0,
    this.username = "",
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.gender = "",
    this.image = "",
    this.name = "",
  });
}
