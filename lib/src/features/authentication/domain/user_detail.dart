class UserDetail {
  final String uid;
  String firstname;
  String lastname;
  final String details;
  final String role = "default";

  UserDetail(this.uid, this.firstname, this.lastname, this.details);

  UserDetail.fromMap(Map<String, dynamic> data)
      : uid = data['user_key'] as String,
        firstname = data['first_name'] as String,
        lastname = data['last_name'] as String,
        details = data['details'] as String;

  Map<String, dynamic> toMap() {
    return {
      'user_key': uid,
      'first_name': firstname,
      'last_name': lastname,
      'details': details,
      'role': role
    };
  }

  String? getFullName() {
    return "$firstname $lastname";
  }
}
