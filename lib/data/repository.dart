import 'package:bloc_test/data/trending_video.dart';
import 'package:bloc_test/data/youtube_api.dart';

class Repository {
  final _api = YoutubeClient();

  Future<List<TrendingVideo>> getTrendingVideos() async {
    return _api.getTrendingVideos();
  }
}
