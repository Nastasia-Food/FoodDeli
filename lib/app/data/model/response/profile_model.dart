// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.data,
  });

  ProfileData? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class ProfileData {
  ProfileData({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.createDate,
    this.updateDate,
    this.image,
  });

  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? username;
  String? createDate;
  String? updateDate;
  String? image;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        createDate: json["create_date"] == null ? null : json["create_date"],
        updateDate: json["update_date"] == null ? null : json["update_date"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "create_date": createDate == null ? null : createDate,
        "update_date": updateDate == null ? null : updateDate,
        "image": image == null ? null : image,
      };
}
