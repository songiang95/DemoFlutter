import 'package:bloc_test/data/trending_video.dart';
import 'package:flutter/material.dart';

class DetailVideoScreen extends StatelessWidget {
  const DetailVideoScreen({
    required this.video,
    Key? key,
  }) : super(key: key);

  final TrendingVideo video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail video")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Image.network(video.videoInfo.thumbnail.url),
          const SizedBox(height: 16),
          Flexible(child: Text(video.videoInfo.title.text))
        ],
      ),
    );
  }
}
