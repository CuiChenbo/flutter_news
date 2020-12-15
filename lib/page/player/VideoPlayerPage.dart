import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({Key key ,  @required this.videoUrl,}) : super(key: key);

  final String videoUrl;

  @override
  _VideoPlayerPageState createState() {
    return _VideoPlayerPageState();
  }
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        allowFullScreen:true,
        fullScreenByDefault:true,
        // aspectRatio: 16/9,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Chewie(controller: _chewieController,),
          FlatButton(
            child: IconButton(icon: Icon(Icons.arrow_back_ios),),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}