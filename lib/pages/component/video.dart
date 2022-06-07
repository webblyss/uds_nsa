
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class ComponentVideoList extends StatefulWidget {
  final video;
  final topic;
  const ComponentVideoList({Key key, this.video, this.topic}) : super(key: key);
  @override
  _ComponentVideoListState createState() => _ComponentVideoListState();
}

class _ComponentVideoListState extends State<ComponentVideoList> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  // FullScreenButton cont = FullScreenButton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.topic}"),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          FullScreenButton(),
          IconButton(
              icon: Icon(
                Icons.cloud_download,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
        onReady: () {
          print("Video is playing");
        },
      ),
    );
  }
}
