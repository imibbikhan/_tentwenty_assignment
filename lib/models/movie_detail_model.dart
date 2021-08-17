import 'package:floor/floor.dart';
import 'dart:convert';

import 'package:ten_twenty_movie/utils/util.dart';

// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

MovieDetailModel movieModelFromJson(String str) =>
    MovieDetailModel.fromJson(json.decode(str));

String movieModelToJson(MovieDetailModel data) => json.encode(data.toJson());

@entity
class MovieDetailModel {
  MovieDetailModel(
      {required this.genres,
      required this.id,
      required this.overview,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.imageUrlList,
      required this.youtubeTrailorId});

  @primaryKey
  int id;
  String genres;
  String overview;
  String releaseDate;
  String title;
  double voteAverage;
  String imageUrlList;
  String youtubeTrailorId;

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        genres: Utils.extracNames(json["genres"]),
        id: json["id"],
        overview: json["overview"],
        releaseDate: json["release_date"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        imageUrlList: "",
        youtubeTrailorId: "",
      );

  Map<String, dynamic> toJson() => {
        "genres": genres,
        "id": id,
        "overview": overview,
        "release_date": releaseDate,
        "title": title,
        "vote_average": voteAverage,
        
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
