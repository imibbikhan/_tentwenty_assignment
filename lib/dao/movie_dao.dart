import 'package:floor/floor.dart';
import 'package:ten_twenty_movie/models/movie_model.dart';

@dao
abstract class MovieDao {
  @Query("DELETE FROM MovieModel")
  Future<void> clearMovieData();

  @Query("SELECT * FROM MovieModel")
  Future<List<MovieModel>?> getAllMovies();

  @insert
  Future<void> insertMovie(MovieModel movie);
}
