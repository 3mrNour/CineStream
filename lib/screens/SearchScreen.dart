import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/providers/search_provider.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:cinestream/widgets/DelightedToastBar.dart';
import 'package:cinestream/widgets/SearchBox.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff291E40), Color(0xff413066)],
            stops: [0.1, 0.9],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SearchBox(),
              ),
              Expanded(
                child: searchProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.amber),
                      )
                    : !searchProvider.isSearchMode
                    ? _buildInitialState()
                    : searchProvider.searchResults.isEmpty
                    ? _buildEmptyState()
                    : _buildResultsGrid(searchProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_creation_outlined,
            size: 80,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 20),
          Text(
            "Find your next favorite movie",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.amber.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          const Text(
            "No movies found!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Try a different keyword",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsGrid(SearchProvider searchProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Wrap(
            runSpacing: 10,
            runAlignment: .center,
            alignment: .center,
            crossAxisAlignment: .center,
            children: [
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    searchProvider.isGenreMode
                        ? searchProvider.currentGenreQuery
                        : searchProvider.currentQuery,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "(${searchProvider.searchResults.length} results found)",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              Spacer(),
              Material(
                color: Colors.transparent,
                child: Ink(
                  child: InkWell(
                    splashColor: Colors.amber.withOpacity(0.3),
                    onTap: () {
                      searchProvider.clearSearch();
                      CustomToast.show(
                        context,
                        status: ToastStatus.searchCleared,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.15),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.5),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Clear Search",
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.7,
            ),
            itemCount: searchProvider.searchResults.length,
            itemBuilder: (context, index) {
              final movie = searchProvider.searchResults[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieScreen(movie: movie),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.05),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      fit: .expand,
                      children: [
                        movie.posterPath.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    ApiEndpoints().ImageBaseUrl +
                                    movie.posterPath,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.amber,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.error,
                                      color: Colors.amber,
                                    ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white54,
                                  size: 40,
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 200,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color.fromARGB(255, 0, 0, 0),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 12,
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                  movie.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: .w600,
                                    fontSize: 16,
                                  ),
                                  maxLines: 3,
                                  overflow: .ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          width: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                15,
                                15,
                                12,
                              ).withOpacity(0.5),

                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: .bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
