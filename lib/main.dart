import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("videos/exemplo.mp4")
      ..setLooping(true) //padrao é false
      ..initialize().then((_) {
        setState(() {
          //_controller.play();
        });
      });

    /*
    _controller = VideoPlayerController.network(
      "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
    )..initialize().then((_){
      setState(() {
        _controller.play();
      });
   });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.initialized //verificar se foi inicilizado
            ? AspectRatio( //se sim
                //area que o video sera executado
                aspectRatio: _controller.value.aspectRatio, //largura e altura
                child: VideoPlayer(_controller), //executar o video
              )
            : Text("Pressione Play"), //se não
      ),
      floatingActionButton: FloatingActionButton(
        child: _controller.value.isPlaying ? Icon(Icons.pause): Icon(Icons.play_arrow),
          onPressed: (){
            setState(() {
              _controller.value.isPlaying ? _controller.pause(): _controller.play();
            });
          }
      ),
    );
  }
}
