import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:playxenos/app/models/position_data.dart';
import 'package:playxenos/app/pages/widgets/controls_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../pages/widgets/media_metadata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _audioPlayer;

  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
      Uri.parse(
          'https://65381g.ha.azioncdn.net/6/e/c/f/japaozin-solinho-do-brabo-d56c033d.mp3'),
      tag: MediaItem(
        id: '0',
        title: 'Nature Sounds',
        artist: 'Public Domain',
        artUri: Uri.parse(
            'https://img.freepik.com/psd-gratuitas/modelo-de-midia-social-para-festa-de-sabado_505751-2942.jpg'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://65381g.ha.azioncdn.net/4/b/2/4/escadacima-contratempo-01bb22d3.mp3'),
      tag: MediaItem(
        id: '1',
        title: 'Contara tempo',
        artist: 'Boi tatá',
        artUri: Uri.parse(
            'https://i.pinimg.com/736x/30/78/8a/30788a3424b042643a1c8894a9be87bb.jpg'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://65381g.ha.azioncdn.net/9/5/4/9/lamparinaeaprimavera-to-que-to-a-toa-58d1a863.mp3'),
      tag: MediaItem(
        id: '2',
        title: 'Lamparaina',
        artist: 'To que to a toa',
        artUri: Uri.parse(
            'https://img.elo7.com.br/product/original/29C0EF1/flyer-para-evento-shows-festas-encontros-etc-flyer.jpg'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://65381g.ha.azioncdn.net/d/5/5/5/eogrego-pane-no-sistema-ae865de2.mp3'),
      tag: MediaItem(
        id: '3',
        title: 'E o grego',
        artist: 'Pane no sistema',
        artUri: Uri.parse(
            'https://i.pinimg.com/736x/34/1d/d2/341dd27156233d59ac45570f2965e735.jpg'),
      ),
    ),
  ]);

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position: position,
          bufferedPosition: bufferedPosition,
          duration: duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFc31432), Color(0xFF240b36)]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                final metada = state!.currentSource!.tag as MediaItem;
                return MediaMetadata(
                  imageUrl: metada.artUri.toString(),
                  artist: metada.artist ?? '',
                  tittle: metada.title,
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StreamBuilder(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return ProgressBar(
                    barHeight: 8,
                    baseBarColor: Colors.grey,
                    progressBarColor: Colors.red,
                    thumbColor: Colors.red,
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _audioPlayer.seek,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ControlsWidget(audioPlayer: _audioPlayer),
          ],
        ),
      ),
    );
  }
}
