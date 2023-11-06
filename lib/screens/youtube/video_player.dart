import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class YoutubeVideoPlayer extends StatefulWidget {
  String id;
  String title;
  String description;

  YoutubeVideoPlayer(
      {super.key,
      required this.id,
      required this.title,
      required this.description});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _YoutubeVideoPlayerState createState() =>
      // ignore: no_logic_in_create_state
      _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
          mute: false, autoPlay: true, hideControls: false),
    )..addListener(listener);
  }

  void listener() {
    setState(() {
      _fullScreen = _controller.value.isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: _fullScreen
            ? AppBar(
                backgroundColor: Colors.transparent,
              )
            : AppBar(
                title: const Text('یو ٹیوب ویڈیو'),
                backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                centerTitle: true,
              ),
        backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      if (kDebugMode) {
                        print('Player is ready.');
                      }
                    },
                  ),
                  builder: (context, player) {
                    return Container(
                      child: player,
                    );
                  }),
              const SizedBox(
                height: 20,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 3, 20, 20),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
