import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:playxenos/app/play_root.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const PlayRoot());
}
