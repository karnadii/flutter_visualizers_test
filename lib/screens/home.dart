import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/exoplayer.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/LineVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../blocs/main.dart';
import 'package:flutter_visualizers/flutter_visualizers.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Injector.get<MainBloc>();
    return Scaffold(
        appBar: AppBar(
          title: Text(bloc.judul),
        ),
        body: StateBuilder(
          tag: "MainBody",
          viewModels: [bloc],
          initState: (_, id) => bloc.initAudioPlayer(),
          builder: (_, id) => Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            width:  MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                height: 50.0,
                minWidth: 100.0,
                color: Colors.blue,
                child: Text(!bloc.isPlaying ? "Play" : "Pause", style: TextStyle(color: Colors.white),),
                onPressed: !bloc.isPlaying ? bloc.play : bloc.stop,
              ),
              if (bloc.audioId != null && bloc.isPlaying)
                Visualizer(
                  builder: (BuildContext context, List<int> wave) {
                    return new CustomPaint(
                      painter: LineBarVisualizer(
                        waveData: wave,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blueAccent,
                      ),
                      child: new Container(),
                    );
                  },
                  id: bloc.audioId,
                )
            ],
          )),
        ));
  }
}
