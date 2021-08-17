import 'package:get_it/get_it.dart';
import 'package:ten_twenty_movie/controllers/home_movie_controller.dart';
import 'package:ten_twenty_movie/controllers/movie_detail_controller.dart';
import 'package:ten_twenty_movie/providers/home_movie_provider.dart';
import 'package:ten_twenty_movie/providers/movie_detail_provider.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<HomeMovieProvider>(() => HomeMovieProvider());
  locator
      .registerLazySingleton<MovieDetailProvider>(() => MovieDetailProvider());
  locator
      .registerLazySingleton<HomeMovieController>(() => HomeMovieController());
  locator.registerLazySingleton<MovieDetailController>(
      () => MovieDetailController());
}
