import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wortschatz/View/home_view.dart';
import 'package:wortschatz/view/splash_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState(){
     super.initState();

     _controller = VideoPlayerController.asset(
       'assets/images/apploading.mp4'
     )..initialize().then((_) {
       setState(() {

       });
     })..setVolume(0.0);
     _playVideo();
  }

  void _playVideo() async {
    _controller.play();

    await Future.delayed(const Duration(milliseconds: 3200));


    Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(
              _controller,
              ),
            )
            : Container(),
        ),
    );
  }

  }
