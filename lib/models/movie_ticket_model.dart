// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

import 'package:floor/floor.dart';

MovieTicketModel movieModelFromJson(String str) =>
    MovieTicketModel.fromJson(json.decode(str));

String movieModelToJson(MovieTicketModel data) => json.encode(data.toJson());

@entity
class MovieTicketModel {
  MovieTicketModel({
    required this.id,
    required this.seatNumber,
    required this.location,
    required this.cinema,
  });
  @primaryKey
  int id;
  String seatNumber;
  String location;
  String cinema;

  factory MovieTicketModel.fromJson(Map<String, dynamic> json) => MovieTicketModel(
        id: json["id"],
        seatNumber: json["seatNumber"],
        location: json["location"],
        cinema: json["cinema"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seatNumber": seatNumber,
        "location": location,
        "cinema": cinema,
      };
}
