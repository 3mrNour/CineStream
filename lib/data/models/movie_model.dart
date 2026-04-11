// To parse this JSON data, do
//
//     final MoviesResponse = welcomeFromJson(jsonString);

import 'dart:convert';

MoviesResponse MoviesResponseFromJson(String str) =>
    MoviesResponse.fromJson(json.decode(str));

String MoviesResponseToJson(MoviesResponse data) => json.encode(data.toJson());

class MoviesResponse {
  int page;
  List<Movie> movies;
  int totalPages;
  int totalMovies;

  MoviesResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalMovies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
    page: json["page"],
    movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalMovies: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(movies.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalMovies,
  };
}

class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final releaseRaw = json["release_date"];
    final releaseDate = (releaseRaw != null &&
            releaseRaw.toString().trim().isNotEmpty)
        ? DateTime.parse(releaseRaw.toString())
        : DateTime.fromMillisecondsSinceEpoch(0);

    return Movie(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"]?.toString() ?? '',
      genreIds: json["genre_ids"] != null
          ? List<int>.from((json["genre_ids"] as List).map((x) => x as int))
          : <int>[],
      id: json["id"] as int,
      originalLanguage: json["original_language"]?.toString() ?? 'en',
      originalTitle: json["original_title"]?.toString() ?? '',
      overview: json["overview"]?.toString() ?? '',
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0,
      posterPath: json["poster_path"]?.toString() ?? '',
      releaseDate: releaseDate,
      title: json["title"]?.toString() ?? '',
      video: json["video"] ?? false,
      voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0,
      voteCount: json["vote_count"] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum OriginalLanguage { EN, KO, RU, ZH }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ko": OriginalLanguage.KO,
  "ru": OriginalLanguage.RU,
  "zh": OriginalLanguage.ZH,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
