import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:ten_twenty_movie/dao/movie_dao.dart';
import 'package:ten_twenty_movie/dao/movie_detail_dao.dart';
import 'package:ten_twenty_movie/dao/movie_ticket_dao.dart';
import 'package:ten_twenty_movie/models/movie_detail_model.dart';
import 'package:ten_twenty_movie/models/movie_model.dart';
import 'package:ten_twenty_movie/models/movie_ticket_model.dart';

part 'movies_database.g.dart';

@Database(
    version: 1, entities: [MovieModel, MovieDetailModel, MovieTicketModel])
abstract class MoviesDatabase extends FloorDatabase {
  MovieDao get moviesDao;

  MovieDetailDao get movieDetailsDao;

  MovieTicketDao get movieTicketDao;
}
