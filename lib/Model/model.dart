class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? lastname;
  UserModel({this.uid, this.email, this.firstname, this.lastname});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],
      lastname: map['lastname'],
    );
    //send
  }
  Map<String, dynamic> tomap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}
