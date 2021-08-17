import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ten_twenty_movie/controllers/home_movie_controller.dart';
import 'package:ten_twenty_movie/models/movie_model.dart';
import 'package:ten_twenty_movie/providers/home_movie_provider.dart';
import 'package:ten_twenty_movie/screens/movie_detail_screen.dart';
import 'package:ten_twenty_movie/screens/movie_ticket_booking_screen.dart';
import 'package:ten_twenty_movie/utils/constants.dart';
import 'package:ten_twenty_movie/utils/get_it_locator.dart';
import 'package:ten_twenty_movie/utils/util.dart';

class HomeMovieScreen extends StatefulWidget {
  const HomeMovieScreen({Key? key}) : super(key: key);

  @override
  _HomeMovieScreenState createState() => _HomeMovieScreenState();
}

class _HomeMovieScreenState extends State<HomeMovieScreen> {
  final HomeMovieController _homeMovieController =
      locator.get<HomeMovieController>();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    if (await _homeMovieController.checkInternetConnectivity()) {
      _homeMovieController.getMovies(context);
    } else {
      _homeMovieController.getSavedMovies(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TenTwenty"),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Consumer<HomeMovieProvider>(
            builder: (context, homeMovieIdentifier, _) {
          if (homeMovieIdentifier.isViewLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (homeMovieIdentifier.movies.isEmpty) {
            return Center(child: Text("No movie found"));
          } else {
            return ListView.builder(
                itemCount: homeMovieIdentifier.movies.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                  movieId:
                                      homeMovieIdentifier.movies[index].id)));
                    },
                    child: _movieListRow(homeMovieIdentifier.movies[index]),
                  );
                });
          }
        }),
      ),
    );
  }

  Widget _movieListRow(MovieModel movie) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: '$BASE_POSTER_IMAGE_URL${movie.posterPath}',
              width: 65,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.releaseDate,
                      style: TextStyle(fontSize: 15, color: Colors.black45),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.adult == true ? "For Adult" : "For anyone",
                      style: TextStyle(fontSize: 15, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<bool>(
              future: Utils.isBooked(movie.id),
              builder: (context, snapshot) {
                return SizedBox(
                  width: snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data == null ||
                          snapshot.data as bool
                      ? 0
                      : 80,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieTicketBookingScreen(movieId: movie.id)));
                    },
                    child: Text(
                      'Book',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider()
      ],
    ));
  }
}
