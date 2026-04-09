import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinestream/data/api/api_client.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/api/constants.dart';
import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/data/models/movie_model.dart';
// import 'package:cinestream/widgets/BottomNavigationBar.dart';
// import 'package:cinestream/widgets/CrystalBar.dart';
import 'package:cinestream/widgets/SearchBox.dart';
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
  Movie? randomMovie;
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
      randomMovie = (upComingMovies..shuffle()).first;
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
          actionsPadding: .symmetric(horizontal: 10),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset('assets/images/Logo_horizontal.png', width: 180),
          toolbarHeight: 100,
          // centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: Colors.amber, size: 28),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite, color: Colors.amber, size: 28),
            ),
          ],
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
                        children: [
                          SearchBox(),
                          Expanded(
                            child: ListView(
                              // crossAxisAlignment: .center,
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
                                SizedBox(
                                  height: 185,
                                  width: .infinity,
                                  child: CarouselSlider.builder(
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
                                                BorderRadiusGeometry.circular(
                                                  20,
                                                ),
                                            child: Stack(
                                              fit: .passthrough,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      ApiEndpoints()
                                                          .ImageBaseUrl +
                                                      upComingMovies[index]
                                                          .backdropPath,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (
                                                        context,
                                                        url,
                                                        downloadProgress,
                                                      ) => Center(
                                                        child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: Color(
                                                                  0xffFFCD30,
                                                                ),
                                                                strokeWidth: 10,
                                                              ),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),

                                                Positioned(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
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
                                                  bottom: 20,
                                                  left: 10,
                                                  right: 10,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        upComingMovies[index]
                                                            .title,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        upComingMovies[index]
                                                            .overview,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 12,
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
                                ),
                                SizedBox(height: 20),
                                if (randomMovie != null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/choices-1.png',
                                          ),
                                          width: 200,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        height: 200,

                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                118,
                                                90,
                                                75,
                                                228,
                                              ),
                                              spreadRadius: 2,
                                              blurRadius: 20,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          color: const Color(0x22FFFFFF),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 255, 166, 2),
                                              Color.fromARGB(
                                                118,
                                                255,
                                                255,
                                                255,
                                              ),
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                              26,
                                              255,
                                              230,
                                              0,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      20,
                                                    ),
                                                    bottomLeft: Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    ApiEndpoints()
                                                        .ImageBaseUrl +
                                                    randomMovie!.posterPath,
                                                width: 130,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      randomMovie!.title,

                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,

                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_month,
                                                          color: Colors.grey,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          randomMovie!
                                                                  .releaseDate
                                                                  .month
                                                                  .toString() +
                                                              "-" +
                                                              (randomMovie!
                                                                      .releaseDate
                                                                      .year)
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          randomMovie!
                                                              .voteAverage
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    // الوصف
                                                    Text(
                                                      randomMovie!.overview,
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 12,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Spacer(),
                                                    // الـ Genre (ممكن تعرض أول ID أو تعمل Map للـ IDs بأسماء الـ Genres)
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 4,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        "Action", // هنا ممكن تعمل دالة تحول الـ ID لاسم
                                                        style: TextStyle(
                                                          color: Colors.amber,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: .center,
                                    children: [
                                      Text(
                                        "All",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Color(0xffFFCD30),
                                          fontSize: 20,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                      Text(
                                        " Genres",
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

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: SizedBox(
                                    height: 160,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 1,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 1.1 / 1.3,
                                          ),
                                      itemCount: genresList.length,
                                      itemBuilder: (context, index) {
                                        final genre = genresList[index];

                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color(
                                                    0xff8747ff,
                                                  ),
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff413066),
                                                    Color(0xff291E40),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                splashColor: Color(0xff413066),
                                                onTap: () {
                                                  print(
                                                    "Filtering by ID: ${genre.id}",
                                                  );
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      genre.icon,
                                                      color: Colors.amber,
                                                      size: 25,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      genre.name,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 8,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      "Top Rated",
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
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 1.1 / 1.5,
                                        ),
                                    itemCount: upComingMovies.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 100,
                                        height: 200,
                                        // margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),

                                          child: CachedNetworkImage(
                                            imageUrl:
                                                ApiEndpoints().ImageBaseUrl +
                                                upComingMovies[index]
                                                    .posterPath,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder:
                                                (
                                                  context,
                                                  url,
                                                  downloadProgress,
                                                ) => Center(
                                                  child: SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Color(
                                                            0xffFFCD30,
                                                          ),
                                                          strokeWidth: 10,
                                                        ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
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