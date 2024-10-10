import 'package:flutter/material.dart';
import 'package:webtoon/webtoon.dart';
import 'package:webtoon/details.dart';

class FavoriteScreenContent extends StatelessWidget {
  final Set<Webtoon> favorites;
  final Function(Webtoon) onToggleFavorite;

  FavoriteScreenContent({required this.favorites, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet. Add some from the home screen!'),
      );
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final webtoon = favorites.elementAt(index);
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
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () => onToggleFavorite(webtoon),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}