import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaMetadata extends StatelessWidget {
  final String imageUrl;
  final String tittle;
  final String artist;

  const MediaMetadata(
      {super.key,
      required this.imageUrl,
      required this.tittle,
      required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          tittle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          artist,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
