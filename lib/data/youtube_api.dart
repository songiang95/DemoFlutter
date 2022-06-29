import "dart:convert";

import 'package:bloc_test/data/trending_video.dart';
import "package:http/http.dart" as http;

const host = "www.youtube.com";
const getKeyEndpoint = "sw.js";
const trendingEndpoint = "youtubei/v1/browse";

class YoutubeClient {
  var _apiKey = "";
  var _clientVersion = "";

  Future<void> authentication() async {
    final uri = Uri.https(host, getKeyEndpoint, {});
    final result = await http.get(uri, headers: _header);

    if (result.statusCode == 200) {
      final body = result.body;
      final split = body.split(",");

      for (var element in split) {
        if (element.contains("INNERTUBE_API_KEY")) {
          _apiKey = element.substring(
              element.indexOf(":\"") + 2, element.lastIndexOf("\""));
        }

        if (element.contains("INNERTUBE_CONTEXT_CLIENT_VERSION")) {
          _clientVersion = element.substring(
              element.indexOf(":\"") + 2, element.lastIndexOf("\""));
        }
      }
    }
  }

  Future<List<TrendingVideo>> getTrendingVideos() async {
    if (_apiKey.isEmpty) {
      await authentication();
    }

    final uri = Uri.https(
        host, trendingEndpoint, {'key': _apiKey, 'prettyPrint': 'false'});

    final response = await http.post(uri, headers: {}, body: _trendingPostBody);

    final jsonObj = json.decode(response.body);

    return jsonObj["contents"]["twoColumnBrowseResultsRenderer"]["tabs"][0]
                    ["tabRenderer"]["content"]["sectionListRenderer"]
                ["contents"][0]["itemSectionRenderer"]["contents"][0]["shelfRenderer"]["content"]
            ["expandedShelfContentsRenderer"]["items"]
        .map<TrendingVideo>(TrendingVideo.fromJson)
        .toList();
  }

  Map<String, String> get _header => {
        'Origin': 'https://www.youtube.com',
        'Referer': 'https://www.youtube.com'
      };

  String get _trendingPostBody => json.encode({
        "browseId": "FEtrending",
        "context": {
          "user": {"lockedSafetyMode": "false"},
          "request": {"internalExperimentFlags": [], "useSsl": "true"},
          "client": {
            "platform": "DESKTOP",
            "hl": "en-GB",
            "clientName": "WEB",
            "gl": "VN",
            "originalUrl": "https://www.youtube.com",
            "clientVersion": _clientVersion
          }
        }
      });
}
