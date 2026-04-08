import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinestream/data/api/api_client.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset('assets/images/Logo_horizontal.png', width: 200),
          toolbarHeight: 100,
          centerTitle: true,
          actions: [],
        ),
        body: Container(
          width: .infinity,
          height: .infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff291E40), Color(0xff413066)],
              stops: [0.1, 0.9],
            ),
          ),
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
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
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
              SafeArea(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFFCD30),
                          strokeWidth: 10,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: .center,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 330,
                              child: TextField(
                                keyboardType: .webSearch,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(68, 255, 255, 255),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xffFFCD30),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(75, 124, 92, 192),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(0, 255, 207, 48),
                                      width: 0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xffFFCD30),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: .center,
                                    children: [
                                      Text(
                                        "Up Coming",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Color(0xffFFCD30),
                                          fontSize: 20,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                      Text(
                                        " Movies",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                CarouselSlider.builder(
                                  itemCount: upComingMovies.length,
                                  itemBuilder: (context, index, realIndex) =>
                                      Container(
                                        // margin: .symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(20),
                                          child: Stack(
                                            fit: .passthrough,
                                            children: [
                                              Image.network(
                                                ApiEndpoints().ImageBaseUrl +
                                                    upComingMovies[index]
                                                        .backdropPath,
                                                fit: .cover,
                                              ),

                                              Positioned(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: [
                                                        Colors.black,
                                                        Colors.transparent,
                                                      ],
                                                      stops: const [0.0, 0.6],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 30,
                                                left: 10,
                                                right: 10,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      upComingMovies[index]
                                                          .title,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      upComingMovies[index]
                                                          .overview,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            const Color.fromARGB(
                                                              104,
                                                              255,
                                                              255,
                                                              255,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    aspectRatio: 1.7,
                                    viewportFraction: .86,
                                    enlargeCenterPage: true,

                                    // enlargeFactor: 1,
                                    autoPlayCurve: Curves.easeInOutCubic,
                                    autoPlayAnimationDuration: Duration(
                                      seconds: 2,
                                    ),
                                    autoPlayInterval: Duration(seconds: 7),
                                    pauseAutoPlayInFiniteScroll: true,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),

                                  child: Row(
                                    mainAxisAlignment: .center,
                                    children: [
                                      Text(
                                        "Popular",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Color(0xffFFCD30),
                                          fontSize: 26,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                      Text(
                                        " Movies",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // GridView.builder(
                                //   gridDelegate:
                                //       SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount: 2,
                                //       ),
                                //   itemCount: upComingMovies.length,
                                //   itemBuilder: (context, index) {
                                //     Container(
                                //       child: Image.network(),
                                //     )
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Column(
//         children: [
//           isLoading
//               ? CircularProgressIndicator()
//               : Expanded(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: popularMovies.length,
//                           itemBuilder: (context, index) => Container(
//                             height: 150,
//                             width: 400,
//                             child: Image.network(
//                               'https://image.tmdb.org/t/p/original/${popularMovies[index].posterPath}',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),



// Column(
//         children: [
//           CarouselSlider.builder(
//             itemCount: popularMovies.length,
//             itemBuilder: (context, index, realIndex) => Container(
//               child: Image.network(
//                 ApiEndpoints().ImageBaseUrl + popularMovies[index].backdropPath,
//               ),
//               decoration: BoxDecoration(
//                 border: index == realIndex
//                     ? Border.all(width: 10, color: Colors.lightGreenAccent)
//                     : null,
//               ),
//             ),
//             options: CarouselOptions(
//               autoPlay: true,
//               aspectRatio: 1.4,
//               enlargeCenterPage: true,
//               autoPlayCurve: Curves.easeInOutCubic,
//               autoPlayAnimationDuration: Duration(seconds: 2),
//               pauseAutoPlayInFiniteScroll: true
//             ),
//           ),
//         ],
//       ),