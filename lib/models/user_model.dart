class UserModel {
  String? name;
  String? id;
  String? email;
  int? age;

  UserModel({this.name, this.email, this.age,this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      id: json['id'],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id':id
    };
  }
}
