import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ten_twenty_movie/dao/movie_detail_dao.dart';
import 'package:ten_twenty_movie/http_repo/http_requests.dart';
import 'package:ten_twenty_movie/local_db/movies_database.dart';
import 'package:ten_twenty_movie/models/movie_detail_model.dart';
import 'package:ten_twenty_movie/models/movie_model.dart';
import 'package:ten_twenty_movie/providers/movie_detail_provider.dart';
import 'package:ten_twenty_movie/utils/constants.dart';

class MovieDetailController {
  MovieDetailModel? _movieDetail;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getMovieDetail(BuildContext context, int movieId) async {
    final url = MOVIE_DETAILS + "/$movieId" + "?api_key=" + API_KEY;
    String movieImagesUrl = '$MOVIE_IMAGES/$movieId/images?api_key=$API_KEY';
    String movieTrailersUrl =
        '$MOVIE_TRAILERS/$movieId/videos?api_key=$API_KEY';

    dynamic movieData = await HttpRequest.makeRequest(context, url);
    MovieDetailModel movieDetail = MovieDetailModel.fromJson(movieData);
    _getMovieImages(
        context, movieId, movieDetail, movieImagesUrl, movieTrailersUrl);
  }

  Future<void> _getMovieImages(
      BuildContext context,
      int movieId,
      MovieDetailModel movie,
      String movieImagesUrl,
      String movieTrailersUrl) async {
    Map<String, dynamic> response =
        await HttpRequest.makeRequest(context, movieImagesUrl);
    List imagesList = [];
    try {
      for (var i in response['backdrops']) {
        if (imagesList.length == 5) break;
        imagesList.add(i['file_path']);
      }

      _movieDetail = MovieDetailModel(
        id: movie.id,
        voteAverage: movie.voteAverage,
        title: movie.title,
        overview: movie.overview,
        releaseDate: movie.releaseDate,
        youtubeTrailorId: movie.youtubeTrailorId,
        genres: movie.genres,
        imageUrlList: jsonEncode(imagesList),
      );
      _getTailorUrls(context, movieId, _movieDetail!, movieTrailersUrl);
    } catch (exc) {
      Provider.of<MovieDetailProvider>(context, listen: false)
          .updateMovie(movie);
    }
  }

  Future<void> _getTailorUrls(BuildContext context, int movieId,
      MovieDetailModel movie, String movieTrailersUrl) async {
    Map<String, dynamic> response =
        await HttpRequest.makeRequest(context, movieTrailersUrl);
    try {
      _movieDetail = MovieDetailModel(
        id: movie.id,
        voteAverage: movie.voteAverage,
        title: movie.title,
        overview: movie.overview,
        releaseDate: movie.releaseDate,
        youtubeTrailorId: response['results'][0]['key'],
        genres: movie.genres,
        imageUrlList: movie.imageUrlList,
      );
      _saveMovieDetailLocal(movie, movieId);
      Provider.of<MovieDetailProvider>(context, listen: false)
          .updateMovie(_movieDetail!);
    } catch (exe) {
      Provider.of<MovieDetailProvider>(context, listen: false)
          .updateMovie(movie);
    }
  }

  Future<void> _saveMovieDetailLocal(
      MovieDetailModel movie, int movieId) async {
    final database = await $FloorMoviesDatabase
        .databaseBuilder("movies_database.db")
        .build();
    MovieDetailDao movieDetailDao = database.movieDetailsDao;
    if (_movieDetail != null) {
      await movieDetailDao.insertMovie(_movieDetail!);
    }
    // when fetching all movies details it works.
    // List<MovieDetailModel>? movies = await movieDetailDao.getAllMoviesDetals();
    // if (movies != null) {
    //   for (MovieDetailModel movie in movies) {
    //     print(movie.title);
    //   }
    // } else {
    //   print("values are null");
    // }
  }
  
  // There is issue with query (Says Syntax error) when getting specific movie from local db. 
  // Current query is from Floor documentation but still not working. 
  Future<void> getSAvedMovieDetail(BuildContext context, int movieId) async {
    final database = await $FloorMoviesDatabase
        .databaseBuilder("movies_database.db")
        .build();
    MovieDetailDao movieDetailDao = database.movieDetailsDao;
    MovieDetailModel? movie =
        await movieDetailDao.getMovieDetail(movieId) ?? null;
    Provider.of<MovieDetailProvider>(context, listen: false).updateMovie(movie);
  }
}
