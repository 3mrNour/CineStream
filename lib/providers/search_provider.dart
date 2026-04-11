import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/data/services/movies_services.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final MoviesServices _services = MoviesServices();

  List<Movie> _searchResults = [];
  bool _isLoading = false;
  bool _isSearchMode = false;

  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearchMode => _isSearchMode;

  Future<void> submitSearch(String query) async {
    // if (query.trim().isEmpty) {
    //   clearSearch();
    //   return;
    // }
    _isSearchMode = true;
    _isLoading = true;
    notifyListeners();

    _searchResults = await _services.searchMovies(query);

    _isLoading = false;
    notifyListeners();
  }

  // void clearSearch() {
  //   _isSearchMode = false;
  //   _searchResults = [];
  //   notifyListeners();
  // }
}
