class User {
  int? id;
  String fname;
  String lname;
  String email;
  String password;

  User(
    this.fname,
    this.lname,
    this.email,
    this.password,
  );

  Map<String, dynamic> toUserMap() {
    var map = <String, dynamic>{};
    map["fname"] = fname;
    map["lname"] = lname;
    map["email"] = email;
    map["password"] = password;
    if (id != null) {
      map["id"] = id!;
    }

    return map;
  }

  static fromUserMap(Map<String, dynamic> c) {
    return User(c['fname'], c['lname'], c['email'], c['password']);
  }
}
