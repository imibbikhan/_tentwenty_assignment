import 'package:floor/floor.dart';
import 'dart:convert';

// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

@entity
class MovieModel {
  MovieModel({
    required this.adult,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
  });

  @primaryKey
  final int id;
  final bool adult;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"],
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
      };
}
