import 'dart:collection';

import 'package:bloc_test/data/repository.dart';
import 'package:flutter/material.dart';

import '../data/trending_video.dart';

class TrendingModel extends ChangeNotifier {
  final repository = Repository();
  final List<TrendingVideo> _videos = [];

  UnmodifiableListView<TrendingVideo> get videos =>
      UnmodifiableListView(_videos);

  late TrendingVideo detailVideo;

  bool? loading;

  Future<void> getTrendingVideo() async {
    loading = true;
    notifyListeners();
    _videos.addAll(await repository.getTrendingVideos());

    loading = false;
    notifyListeners();
  }

  void onItemClicked(TrendingVideo video) {
    detailVideo = video;
  }



}
