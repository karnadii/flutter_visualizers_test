import 'dart:async';

import 'package:flutter_exoplayer/exoplayer.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MainBloc extends StatesRebuilder {
  ExoPlayer exoPlayer;
  String url = "http://masima.rastream.com/masima-pramborsjakarta?";
String kUrl1 = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3';
  PlayerState playerState = PlayerState.RELEASED;
  StreamSubscription durationSubscription;
  StreamSubscription positionSubscription;
  StreamSubscription playerCompleteSubscription;
  StreamSubscription playerErrorSubscription;
  StreamSubscription playerStateSubscription;
  StreamSubscription playerIndexSubscription;
  StreamSubscription playerAudioSessionIdSubscription;
  bool get isPlaying => playerState == PlayerState.PLAYING;
  String judul = "Radio Suka";
  int audioId;
  void initAudioPlayer() {
    print("audio player init");
    exoPlayer = ExoPlayer();
    playerStateSubscription =
        exoPlayer.onPlayerStateChanged.listen((state) {
      playerState = state;
      rebuildStates(["MainBody"]);
    });

    playerAudioSessionIdSubscription =
        exoPlayer.onAudioSessionIdChange.listen((audioSessionId) {
      print("audio Session Id: $audioSessionId");
      audioId = audioSessionId;
      rebuildStates(["MainBody"]);
    });
  }

  void play() async {
    final Result result = await exoPlayer.play(
      url,
      repeatMode: true,
      respectAudioFocus: false,
      playerMode: PlayerMode.BACKGROUND,
    );
    if (result == Result.error) {
      print("something went wrong in play method :(");
    }
  }

  Future<void> resume() async {
    final Result result = await exoPlayer.resume();
    if (result == Result.fail) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.error) {
      print("something went wrong in resume :(");
    }
  }

  Future<void> pause() async {
    final Result result = await exoPlayer.pause();
    if (result == Result.fail) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.error) {
      print("something went wrong in pause :(");
    }
  }

  Future<void> stop() async {
    final Result result = await exoPlayer.stop();
    if (result == Result.fail) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.error) {
      print("something went wrong in stop :(");
    }
  }

  Future<void> release() async {
    final Result result = await exoPlayer.release();
    if (result == Result.fail) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.error) {
      print("something went wrong in release :(");
    }
  }
}
