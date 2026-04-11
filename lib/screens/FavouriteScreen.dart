import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinestream/data/api/api_client.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ApiClient apiClient = ApiClient();
  List<Movie> upComingMovies = [];
  bool isLoading = true;
  Future<List<Movie>> getupComingMovies() async {
    try {
      var upComingMoviesRes = await apiClient.getData(
        ApiEndpoints().upComingMovies,
      );
      if (upComingMoviesRes.statusCode == 200 &&
          upComingMoviesRes.data != null) {
        isLoading = false;
        return MoviesResponse.fromJson(upComingMoviesRes.data).movies;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  void loadMovies() async {
    var movies = await getupComingMovies();
    setState(() {
      upComingMovies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Screen')),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Opacity(
                opacity: 0.1,
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.black, Colors.transparent],
                      stops: [0.0, 0.7, 1.0],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    'assets/images/HD-wallpaper-horror-movie-posters-movies-poster-vintage.jpg',
                    scale: 0.2,
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
