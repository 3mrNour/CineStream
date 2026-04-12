import 'package:cinestream/data/api/constants.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class ApiEndpoints {
  final upComingMovies = '/movie/upcoming';
  final popularMovies = '/movie/popular';
  final topRatedMovies = '/movie/top_rated';
  final nowPlayingMovies = '/movie/now_playing';
  final searchMovies = '/search/movie?query=';
  String getRelatedShows(movie_id) {
    return 'https://api.themoviedb.org/3/movie/${movie_id}/recommendations';
  }

  String getByGenre(genre_id) {
    return 'https://api.themoviedb.org/3/discover/movie?with_genres=${genre_id}';
  }

  final ImageBaseUrl = 'https://image.tmdb.org/t/p/original/';
}
