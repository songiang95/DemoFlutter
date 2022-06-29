class TrendingVideo {
  late final VideoInfo videoInfo;

  TrendingVideo.fromJson(dynamic json) : videoInfo = VideoInfo.fromJson(json["videoRenderer"]);
}

class VideoInfo {
  late final String videoId;
  late final Thumbnail thumbnail;
  late final Title title;

  VideoInfo.fromJson(Map json)
      : videoId = json["videoId"],
        thumbnail = Thumbnail.fromJson(json["thumbnail"]),
        title = Title.fromJson(json["title"]);
}

class Thumbnail {
  late final String url;

  Thumbnail.fromJson(Map json) : url = json["thumbnails"][2]["url"];
}

class Title {
  late final String text;

  Title.fromJson(Map json) : text = json["runs"][0]["text"];
}
