class Admin {
  int? id;
  String name;
  String password;

  Admin(
    this.name,
    this.password,
  );

  Map<String, dynamic> toAdminMap() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["password"] = password;
    if (id != null) {
      map["id"] = id!;
    }

    return map;
  }

  static fromAdminMap(Map<String, dynamic> c) {
    return Admin(c['name'], c['password']);
  }
}
