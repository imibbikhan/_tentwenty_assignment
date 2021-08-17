import 'package:floor/floor.dart';
import 'package:ten_twenty_movie/models/movie_detail_model.dart';

@dao
abstract class MovieDetailDao {
  @Query("SELECT FROM MovieDetailModel WHERE id = :id")
  Future<MovieDetailModel?> getMovieDetail(int id);

  @Query("SELECT * FROM MovieDetailModel")
  Future<List<MovieDetailModel>?> getAllMoviesDetals();

  @insert
  Future<void> insertMovie(MovieDetailModel movieDetail);
}
