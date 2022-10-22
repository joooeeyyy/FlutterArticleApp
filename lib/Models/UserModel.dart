import 'dart:convert';

UserNew userNewFromJson(String str) => UserNew.fromJson(json.decode(str));

String userNewToJson(UserNew data) => json.encode(data.toJson());

class UserNew {
  UserNew({
    this.message,
    this.name,
    this.isAdmin,
    this.profilePicture,
    this.coverPhoto,
    this.following,
    this.followers,
    this.id,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
  });

  String? message;
  String? name;
  bool? isAdmin;
  String? profilePicture;
  String? coverPhoto;
  List<dynamic>? following;
  List<dynamic>? followers;
  String? id;
  String? email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;

  factory UserNew.fromJson(Map<String, dynamic> json) => UserNew(
    message: json["message"],
    name: json["name"],
    isAdmin: json["isAdmin"],
    profilePicture: json["profilePicture"],
    coverPhoto: json["coverPhoto"],
    following: List<dynamic>.from(json["following"].map((x) => x)),
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "name": name,
    "isAdmin": isAdmin,
    "profilePicture": profilePicture,
    "coverPhoto": coverPhoto,
    "following": null,
    "followers": null,
    "_id": id,
    "email": email,
    "password": password,
    "createdAt": null,
    "updatedAt": null,
    "__v": v,
    "token": token,
  };
}
