import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ten_twenty_movie/dao/movie_dao.dart';
import 'package:ten_twenty_movie/http_repo/http_requests.dart';
import 'package:ten_twenty_movie/local_db/movies_database.dart';
import 'package:ten_twenty_movie/models/movie_model.dart';
import 'package:ten_twenty_movie/providers/home_movie_provider.dart';
import 'package:ten_twenty_movie/utils/constants.dart';
import 'package:ten_twenty_movie/utils/get_it_locator.dart';

class HomeMovieController {
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getMovies(BuildContext context) async {
    String url = ALL_MOVIES + "?api_key=" + API_KEY;
    Map<String, dynamic> movieData =
        await HttpRequest.makeRequest(context, url) ?? {};
    List<MovieModel> moviesList = List<MovieModel>.from(
        movieData["results"].map((model) => MovieModel.fromJson(model)));
    if (moviesList.isNotEmpty) _saveMoviesLocal(moviesList);
    Provider.of<HomeMovieProvider>(context, listen: false)
        .addMovies(moviesList);
  }

  Future<void> _saveMoviesLocal(List<MovieModel> movies) async {
    final database = await $FloorMoviesDatabase
        .databaseBuilder("movies_database.db")
        .build();
    MovieDao movieDao = database.moviesDao;
    movieDao.clearMovieData();
    for (MovieModel movie in movies) {
      await movieDao.insertMovie(movie);
    }
  }

  Future<void> getSavedMovies(BuildContext context) async {
    final database = await $FloorMoviesDatabase
        .databaseBuilder("movies_database.db")
        .build();
    MovieDao movieDao = database.moviesDao;
    List<MovieModel> moviesList = await movieDao.getAllMovies() ?? [];
    Provider.of<HomeMovieProvider>(context, listen: false)
        .addMovies(moviesList);
  }
}
