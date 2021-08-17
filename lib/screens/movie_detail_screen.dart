import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:ten_twenty_movie/Utils/constants.dart';
import 'package:ten_twenty_movie/Utils/util.dart';
import 'package:ten_twenty_movie/controllers/movie_detail_controller.dart';
import 'package:ten_twenty_movie/providers/movie_detail_provider.dart';
import 'package:ten_twenty_movie/screens/movie_trailer_screen.dart';
import 'package:ten_twenty_movie/utils/get_it_locator.dart';

class MovieDetailScreen extends StatefulWidget {
  int movieId;
  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailController _movieDetailController =
      locator.get<MovieDetailController>();

  @override
  void initState() {
    super.initState();
    _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    if (await _movieDetailController.checkInternetConnectivity()) {
      _movieDetailController.getMovieDetail(context, widget.movieId);
    } else {
      _movieDetailController.getSAvedMovieDetail(context, widget.movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Consumer<MovieDetailProvider>(
        builder: (context, movieDetailIdentifier, _) {
          if (movieDetailIdentifier.isViewLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (movieDetailIdentifier.movie == null) {
            return Center(child: Text("No details found"));
          } else {
            List imagesList =
                jsonDecode(movieDetailIdentifier.movie!.imageUrlList);
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1.0,
                      ),
                      items: imagesList.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CachedNetworkImage(
                              imageUrl: '$BASE_POSTER_IMAGE_URL/$imagePath',
                              width: Utils.getScreenFullWidth(context),
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      JumpingDotsProgressIndicator(
                                fontSize: 32.0,
                                color: Colors.blue,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieDetailIdentifier.movie?.title ?? "",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          YoutubeTrailerScreen(
                                              movieDetailIdentifier
                                                  .movie!.youtubeTrailorId)));
                            },
                            child: Text(
                              'Watch Trailer',
                              style: TextStyle(fontSize: 17),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Genere",
                            style: smallTitleStyle(),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(movieDetailIdentifier.movie?.genres ?? ""),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating:
                                    movieDetailIdentifier.movie!.voteAverage,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.orangeAccent,
                                ),
                                itemCount: 10,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '(${movieDetailIdentifier.movie!.voteAverage})',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Date",
                            style: smallTitleStyle(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(movieDetailIdentifier.movie?.releaseDate ?? ""),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Overview",
                            style: smallTitleStyle(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            movieDetailIdentifier.movie?.overview ?? "",
                            maxLines: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  TextStyle smallTitleStyle() {
    return TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  }
}
