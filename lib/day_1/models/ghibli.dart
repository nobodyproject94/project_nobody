// To parse this JSON data, do
//
//     final ghibli = ghibliFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'ghibli.g.dart';

List<Ghibli> ghibliFromJson(String str) =>
    List<Ghibli>.from(json.decode(str).map((x) => Ghibli.fromJson(x)));

String ghibliToJson(List<Ghibli> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Ghibli {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "original_title")
  String originalTitle;
  @JsonKey(name: "original_title_romanised")
  String originalTitleRomanised;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "movie_banner")
  String movieBanner;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "director")
  String director;
  @JsonKey(name: "producer")
  String producer;
  @JsonKey(name: "release_date")
  String releaseDate;
  @JsonKey(name: "running_time")
  String runningTime;
  @JsonKey(name: "rt_score")
  String rtScore;
  @JsonKey(name: "people")
  List<String> people;
  @JsonKey(name: "species")
  List<String> species;
  @JsonKey(name: "locations")
  List<String> locations;
  @JsonKey(name: "vehicles")
  List<String> vehicles;
  @JsonKey(name: "url")
  String url;

  Ghibli({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.image,
    required this.movieBanner,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rtScore,
    required this.people,
    required this.species,
    required this.locations,
    required this.vehicles,
    required this.url,
  });

  factory Ghibli.fromJson(Map<String, dynamic> json) => _$GhibliFromJson(json);

  Map<String, dynamic> toJson() => _$GhibliToJson(this);
}
