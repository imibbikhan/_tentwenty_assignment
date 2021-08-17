import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten_twenty_movie/dao/movie_ticket_dao.dart';
import 'package:ten_twenty_movie/local_db/movies_database.dart';
import 'package:ten_twenty_movie/models/movie_ticket_model.dart';
import 'package:ten_twenty_movie/utils/util.dart';

class MovieTicketBookingScreen extends StatefulWidget {
  int movieId;
  MovieTicketBookingScreen({required this.movieId});

  @override
  _MovieTicketBookingScreenState createState() =>
      _MovieTicketBookingScreenState();
}

class _MovieTicketBookingScreenState extends State<MovieTicketBookingScreen> {
  List<String> _locations = ['Islamabad', 'Rawalpindi', 'Karachi'];
  List<String> _cinemas = ['Cinema A', 'Cinema B', 'Cinema C'];
  List<String> _seats = ['Seat A', 'Seat B', 'Seat C'];
  String? _selectedLocation;
  String? _selectedCinema;
  String? _selectedSeat;

  bool isBooked = false;

  @override
  void initState() {
    super.initState();

    _selectedLocation = _locations[0];
    _selectedCinema = _cinemas[0];
    _selectedSeat = _seats[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moving Booking"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.movieId}",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Select City",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              DropdownButton(
                hint: _selectedLocation == null
                    ? Text('Dropdown')
                    : Text(
                        _selectedLocation!,
                        style: TextStyle(color: Colors.blue),
                      ),
                // isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                items: _locations.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _selectedLocation = val.toString();
                    },
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                "Select Cinema",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              DropdownButton(
                hint: _selectedCinema == null
                    ? Text('Dropdown')
                    : Text(
                        _selectedCinema!,
                        style: TextStyle(color: Colors.blue),
                      ),
                // isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                items: _cinemas.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _selectedCinema = val.toString();
                    },
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                "Select Seat",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              DropdownButton(
                hint: _selectedSeat == null
                    ? Text('Dropdown')
                    : Text(
                        _selectedSeat!,
                        style: TextStyle(color: Colors.blue),
                      ),
                // isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                items: _seats.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _selectedSeat = val.toString();
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _bookTicketNow(context, widget.movieId);
                },
                child: Text(
                  'Book Now',
                  style: TextStyle(fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bookTicketNow(BuildContext context, int movieId) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt(widget.movieId.toString(), widget.movieId);

    Utils.displayMessage(context, "Ticked booked");

    final database =
        await $FloorMoviesDatabase.databaseBuilder("movies_database").build();
    MovieTicketDao movieTicketDao = database.movieTicketDao;
    await movieTicketDao.insertMovieTicket(
      MovieTicketModel(
        id: widget.movieId,
        seatNumber: _selectedSeat!,
        location: _selectedLocation!,
        cinema: _selectedCinema!,
      ),
    );
  }
}
