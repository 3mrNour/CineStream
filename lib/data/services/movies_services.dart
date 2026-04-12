import 'package:cinestream/data/api/api_client.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoviesServices {
  ApiClient apiClient = ApiClient();

  Future<List<Movie>> getupComingMovies() async {
    try {
      var upComingMoviesRes = await apiClient.getData(
        ApiEndpoints().upComingMovies,
      );
      if (upComingMoviesRes.statusCode == 200 &&
          upComingMoviesRes.data != null) {
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

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      var topRatedMoviesRes = await apiClient.getData(
        ApiEndpoints().topRatedMovies,
      );
      if (topRatedMoviesRes.statusCode == 200 &&
          topRatedMoviesRes.data != null) {
        return MoviesResponse.fromJson(topRatedMoviesRes.data).movies;
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

  Future<List<Movie>> getPopularMovies() async {
    try {
      var popularMoviesRes = await apiClient.getData(
        ApiEndpoints().popularMovies,
      );
      if (popularMoviesRes.statusCode == 200 && popularMoviesRes.data != null) {
        return MoviesResponse.fromJson(popularMoviesRes.data).movies;
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

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      var nowPlayingMoviesRes = await apiClient.getData(
        ApiEndpoints().nowPlayingMovies,
      );
      if (nowPlayingMoviesRes.statusCode == 200 &&
          nowPlayingMoviesRes.data != null) {
        return MoviesResponse.fromJson(nowPlayingMoviesRes.data).movies;
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

  Future<List<Movie>> getRelatedMovies(Movie movie) async {
    try {
      var RelatedMoviesRes = await apiClient.getData(
        ApiEndpoints().getRelatedShows(movie.id),
      );
      if (RelatedMoviesRes.statusCode == 200 && RelatedMoviesRes.data != null) {
        return MoviesResponse.fromJson(RelatedMoviesRes.data).movies;
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

  Future<List<Movie>> searchMovies(String query) async {
    try {
      var response = await apiClient.getData(
        ApiEndpoints().searchMovies + Uri.encodeComponent(query),
      );
      if (response.statusCode == 200 && response.data != null) {
        return MoviesResponse.fromJson(response.data).movies;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getMoviesByGenre(int genreId) async {
    try {
      String url =
          ApiEndpoints().getByGenre(genreId);

      var response = await apiClient.getData(url);

      if (response.statusCode == 200 && response.data != null) {
        return MoviesResponse.fromJson(response.data).movies;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching genre movies: $e");
      }
      return [];
    }
  }
}
