import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:webtoon/database_helper.dart';
import 'package:webtoon/details.dart';
import 'package:webtoon/favourite.dart';
import 'package:webtoon/webtoon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webtoon Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 171, 139, 225)),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  Set<Webtoon> _favorites = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await DatabaseHelper.instance.getFavorites();
    setState(() {
      _favorites = Set.from(favorites);
    });
  }

  Future<void> toggleFavorite(Webtoon webtoon) async {
    setState(() {
      if (_favorites.contains(webtoon)) {
        _favorites.remove(webtoon);
        DatabaseHelper.instance.deleteFavorite(webtoon.title);
      } else {
        _favorites.add(webtoon);
        DatabaseHelper.instance.insertFavorite(webtoon);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      WebtoonListScreen(favorites: _favorites, onToggleFavorite: toggleFavorite),
      FavoriteScreenContent(favorites: _favorites, onToggleFavorite: toggleFavorite),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Webtoon Info'),
      ),
      body: _screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 45,
        items: [
          Icon(Icons.home_rounded),
          Icon(Icons.favorite_outlined),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}

class WebtoonListScreen extends StatelessWidget {
  final Set<Webtoon> favorites;
  final Function(Webtoon) onToggleFavorite;

  WebtoonListScreen({required this.favorites, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: top50Manhwa.map((webtoon) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(webtoon.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebtoonDetailScreen(
                                title: webtoon.title,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          webtoon.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        webtoon.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text(webtoon.rating.toString()),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              favorites.contains(webtoon) ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async => await onToggleFavorite(webtoon),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}