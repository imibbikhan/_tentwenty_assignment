import 'package:flutter/material.dart';
import 'package:ten_twenty_movie/models/movie_detail_model.dart';

class MovieDetailProvider extends ChangeNotifier {
  MovieDetailModel? movie;
  bool isViewLoading = true;

  void updateMovie(MovieDetailModel? movie) {
    this.movie = movie;
    isViewLoading = false;
    notifyListeners();
  }
}
