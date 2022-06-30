import 'package:bloc_test/data/trending_video.dart';
import 'package:bloc_test/provider/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingVideoScreen extends StatelessWidget {
  const TrendingVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trending video")),
      body: Consumer<TrendingModel>( //                       <-- Consumer
            builder: (context, model, child) {
              if (model.loading == null) {
                return Center(
                    child: GestureDetector(
                  onTap: () => model.getTrendingVideo(),
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Get Video',
                        ),
                      )),
                ));
              } else if (model.loading == true) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.blue));
              } else {
                return const ListVideo();
              }
            },
          ),
    );
  }
}

class ListVideo extends StatelessWidget {
  const ListVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrendingModel>(builder: (context, model, child) { //    <-- Consumer
      if (model.videos.isEmpty) {
        return const Center(child: Text("Empty"));
      } else {
        return ListView.builder(
            itemCount: model.videos.length,
            itemBuilder: (context, index) {
              final video = model.videos[index];
              return VideoItem(video: video);
            });
      }
    });
  }
}

class VideoItem extends StatelessWidget {
  const VideoItem({
    required this.video,
    Key? key,
  }) : super(key: key);

  final TrendingVideo video;

  @override
  Widget build(BuildContext context) {
    final model = context.read<TrendingModel>(); //    <-- Provider.of

    return TextButton(
      style: TextButton.styleFrom(primary: Colors.black),
      onPressed: () => {
        model.onItemClicked(video),
        Navigator.pushNamed(context, '/detail')
      },
      child: Row(children: [
        Image.network(video.videoInfo.thumbnail.url, width: 100, height: 80),
        Flexible(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(video.videoInfo.title.text)),
        ),
      ]),
    );
  }
}
