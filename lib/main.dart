import 'package:flutter/material.dart';

const Color netflixRed = Color(0xFFE50914);
const Color netflixBlack = Color(0xFF141414);
const Color netflixDarkGrey = Color(0xFF1F1F1F);
const Color netflixGrey = Color(0xFF2B2B2B);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: netflixBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: netflixDarkGrey,
          foregroundColor: netflixRed,
          elevation: 4,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: netflixRed, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: netflixGrey,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: netflixRed,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: netflixDarkGrey,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        colorScheme: const ColorScheme.dark(
          primary: netflixRed,
          surface: netflixDarkGrey,
        ),
      ),
      home: const MoviePage(),
    );
  }
}

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final List<Movie> movies = const [
    Movie(
      title: 'Inception',
      genre: 'Sci-Fi',
      year: 2010,
      duration: 148,
      rating: 8.8,
    ),
    Movie(
      title: 'Parasite',
      genre: 'Thriller',
      year: 2019,
      duration: 132,
      rating: 8.6,
    ),
    Movie(
      title: 'Spirited Away',
      genre: 'Animation',
      year: 2001,
      duration: 125,
      rating: 8.5,
    ),
    Movie(
      title: 'The Dark Knight',
      genre: 'Action',
      year: 2008,
      duration: 152,
      rating: 9.0,
    ),
    Movie(
      title: 'La La Land',
      genre: 'Romance',
      year: 2016,
      duration: 128,
      rating: 8.0,
    ),
  ];
  late Movie selectedMovie;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedMovie = movies.first;
  }

  Future<void> selectMovie(Movie movie) async {
    setState(() {
      isLoading = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }

    setState(() {
      selectedMovie = movie;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.local_movies, color: netflixRed),
            SizedBox(width: 8),
            Text(
              'Movie List',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Movie',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedMovie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Genre: ${selectedMovie.genre}',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          Text(
                            'Year: ${selectedMovie.year}',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          Text(
                            'Duration: ${selectedMovie.duration} min',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          Text(
                            'Rating: ${selectedMovie.rating.toStringAsFixed(1)}',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'All Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      onTap: () => selectMovie(movie),
                      leading: const Icon(
                        Icons.movie_outlined,
                        color: netflixRed,
                      ),
                      title: Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${movie.genre} • ${movie.year}',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final String title;
  final String genre;
  final int year;
  final int duration;
  final double rating;

  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.duration,
    required this.rating,
  });
}
