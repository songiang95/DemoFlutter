import 'package:bloc_test/provider/trending_model.dart';
import 'package:bloc_test/ui/detail_video.dart';
import 'package:bloc_test/ui/trending_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TrendingModel(),
      child: Consumer<TrendingModel>(
        builder: (ctx, model, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              '/': (ctx) => const TrendingVideoScreen(),
              '/detail': (ctx) => DetailVideoScreen(video: model.detailVideo)
            },
          );
        },
      ),
    );
  }
}
