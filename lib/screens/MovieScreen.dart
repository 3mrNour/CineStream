import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_client.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({super.key, required this.movie});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  ApiClient apiClient = ApiClient();
  bool isLoadingRelated = true;
  List<Movie> relatedMovies = [];

  @override
  void initState() {
    super.initState();
    LoadRelatedMovies();
  }

  Future<List<Movie>> fetchRelatedMovies() async {
    try {
      var RelatedMoviesRes = await apiClient.getData(
        ApiEndpoints().getRelatedShows(widget.movie.id),
      );
      if (RelatedMoviesRes.statusCode == 200 && RelatedMoviesRes.data != null) {
        isLoadingRelated = false;
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

  String getGenreName(int id) {
    return genresList
        .firstWhere(
          (element) => element.id == id,
          orElse: () =>
              Genre(id: 0, name: "N/A", colors: [], icon: Icons.error),
        )
        .name;
  }

  void LoadRelatedMovies() async {
    var loadedRelatedMovies = await fetchRelatedMovies();
    setState(() {
      relatedMovies = loadedRelatedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.amber,
              size: 28,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                fit: .passthrough,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.7, 1.0],
                      ).createShader(bounds);
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          ApiEndpoints().ImageBaseUrl + movie.backdropPath,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,

                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffFFCD30),
                            ),
                          ),
                      errorWidget: (context, url, error) => Container(
                        height: 350,
                        color: Colors.black26,
                        child: const Icon(
                          Icons.error,
                          color: Colors.amber,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xff291E40), Colors.transparent],
                          stops: [0.0, 0.6],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 18,
                    left: 20,
                    width: 350,
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie!.releaseDate.month.toString() +
                              "-" +
                              (movie!.releaseDate.year).toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Genres (Chips)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genreIds.map((id) {
                        return Container(
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
                            getGenreName(id),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Overview (Story)
                    const Text(
                      "Storyline",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- 3. Related Shows Section ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Text(
                      "Related",
                      style: TextStyle(
                        color: Color(0xffFFCD30),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " Shows",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Related Shows ListView
              SizedBox(
                height: 200,
                child: isLoadingRelated
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFFCD30),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: relatedMovies.length,
                        itemBuilder: (context, index) {
                          final relatedMovie = relatedMovies[index];
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Ink(
                                child: InkWell(
                                  splashColor: Colors.indigoAccent,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieScreen(movie: relatedMovie),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              ApiEndpoints().ImageBaseUrl +
                                              relatedMovie.posterPath,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (
                                                context,
                                                url,
                                                progress,
                                              ) => const Center(
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.amber,
                                                        strokeWidth: 3,
                                                      ),
                                                ),
                                              ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          height: 50,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black87,
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          left: 8,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                relatedMovie.voteAverage
                                                    .toStringAsFixed(1),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
