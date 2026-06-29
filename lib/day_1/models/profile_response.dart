import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:project_nobody/day_1/models/user_model.dart';
import 'package:project_nobody/day_1/models/auth_resnponse.dart';



ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  UserModel? data;

  ProfileResponse({this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$profileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$profileResponseToJson(this);
}