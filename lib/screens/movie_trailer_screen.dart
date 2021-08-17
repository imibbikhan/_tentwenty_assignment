import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeTrailerScreen extends StatefulWidget {
  String _videoId;

  YoutubeTrailerScreen(this._videoId);

  @override
  _YoutubeTrailerScreenState createState() => _YoutubeTrailerScreenState();
}

class _YoutubeTrailerScreenState extends State<YoutubeTrailerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget._videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                onEnded: (_) {
                  Navigator.pop(context);
                },
                controller: _controller,
              ),
              builder: (BuildContext, player) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Done")),
                    ),
                    player
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
