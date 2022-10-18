import 'dart:convert';

AllPost allPostFromJson(String str) => AllPost.fromJson(json.decode(str));

String allPostToJson(AllPost data) => json.encode(data.toJson());

class AllPost {
  AllPost({
    this.message,
    this.post,
  });

  String? message;
  List<Post>? post;

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
    message: json["message"],
    post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "post": List<dynamic>.from(post!.map((x) => x.toJson())),
  };
}

class Post {
  Post({
    this.description,
    this.category,
    this.id,
    this.title,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? description;
  List<String>? category;
  String? id;
  String? title;
  List<Img>? img;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    description: json["description"],
    category: List<String>.from(json["category"].map((x) => x)),
    id: json["_id"],
    title: json["title"],
    img: List<Img>.from(json["img"].map((x) => Img.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "category": List<dynamic>.from(category!.map((x) => x)),
    "_id": id,
    "title": title,
    "img": List<dynamic>.from(img!.map((x) => x.toJson())),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Img {
  Img({
    this.id,
    this.filename,
  });

  String? id;
  String? filename;

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    id: json["_id"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "filename": filename,
  };
}
