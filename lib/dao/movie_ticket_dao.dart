import 'package:floor/floor.dart';
import 'package:ten_twenty_movie/models/movie_ticket_model.dart';

@dao
abstract class MovieTicketDao {
  @Query("SELECT FROM MovieTicketModel WHERE id = :id")
  Future<MovieTicketModel?> getMovieTicket(int id);

  @insert
  Future<void> insertMovieTicket(MovieTicketModel movieTicket);
}
