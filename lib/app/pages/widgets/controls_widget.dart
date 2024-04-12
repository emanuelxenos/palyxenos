import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    const double sizebuton = 50;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          icon: const Icon(
            Icons.skip_previous_rounded,
            color: Colors.white,
            size: sizebuton,
          ),
        ),
        StreamBuilder(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playState = snapshot.data;
            final processingState = playState?.processingState;
            final playing = playState?.playing;

            if (!(playing ?? false)) {
              return IconButton(
                onPressed: audioPlayer.play,
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: sizebuton,
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                icon: const Icon(
                  Icons.pause_rounded,
                  color: Colors.white,
                  size: sizebuton,
                ),
              );
            } else {
              return const Icon(
                Icons.play_arrow,
                color: Colors.white,
              );
            }
          },
        ),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          icon: const Icon(
            Icons.skip_next_rounded,
            color: Colors.white,
            size: sizebuton,
          ),
        ),
      ],
    );
  }
}
