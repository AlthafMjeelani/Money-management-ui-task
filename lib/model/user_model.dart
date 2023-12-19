class UserModel {
  String? email;
  String? name;
  String? mob;
  String? dob;
  String? pp;

  UserModel({
    this.email,
    this.name,
    this.mob,
    this.dob,
    this.pp,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      mob: map['mob'],
      dob: map['dob'],
      pp: map['pp'],
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        "name": name,
        'mob': mob,
        'dob': dob,
        'pp': pp,
      };
}