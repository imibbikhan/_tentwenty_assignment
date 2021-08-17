import 'package:flutter/material.dart';
import 'package:ten_twenty_movie/models/movie_model.dart';

class HomeMovieProvider extends ChangeNotifier {
  List<MovieModel> movies = [];
  bool isViewLoading = true;

  void addMovies(List<MovieModel> movies) {
    this.movies = movies;
    isViewLoading = false;
    notifyListeners();
  }
}
