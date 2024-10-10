import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebtoonDetailScreen extends StatefulWidget {
  final String title;

  const WebtoonDetailScreen({super.key, required this.title});

  @override
  State<WebtoonDetailScreen> createState() => _WebtoonDetailScreenState();
}

class _WebtoonDetailScreenState extends State<WebtoonDetailScreen> {
  late Future<Manga> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchData(widget.title);
  }

  Future<Manga> _fetchData(String title) async {
    final response = await http.get(Uri.parse('https://kitsu.io/api/edge/manga?filter[text]=$title'));

    if (response.statusCode == 200) {
      return Manga.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildMangaDetails(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildMangaDetails(Manga manga) {
  return ListView.builder(
    itemCount: manga.data.length,
    itemBuilder: (context, index) {
      final mangaData = manga.data[index];
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(mangaData.attributes.posterImage?['tiny'] ?? ''),
              const SizedBox(height: 16),
              Text(
                mangaData.attributes.titles?['en'] ?? mangaData.attributes.titles?['en_us'] ?? mangaData.attributes.titles?['en_jp'] ?? '',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(mangaData.attributes.synopsis ?? ''),
              const SizedBox(height: 16),
              Text('Average Rating: ${mangaData.attributes.averageRating ?? ''}'),
              const SizedBox(height: 16),
              Text('User  Count: ${mangaData.attributes.userCount ?? ''}'),
              const SizedBox(height: 16),
              Text('Favorites Count: ${mangaData.attributes.favoritesCount ?? ''}'),
              const SizedBox(height: 16),
              Text('Start Date: ${mangaData.attributes.startDate ?? ''}'),
              const SizedBox(height: 16),
              Text('End Date: ${mangaData.attributes.endDate ?? ''}'),
              const SizedBox(height: 16),
              Text('Status: ${mangaData.attributes.status ?? ''}'),
            ],
          ),
        ),
      );
    },
  );
}
}

class Manga {
  final List<MangaData> data;

  Manga({required this.data});

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      data: (json['data'] as List).map((e) => MangaData.fromJson(e)).toList(),
    );
  }
}

class MangaData {
  final Attributes attributes;

  MangaData({required this.attributes});

  factory MangaData.fromJson(Map<String, dynamic> json) {
    return MangaData(
      attributes: Attributes.fromJson(json['attributes']),
    );
  }
}

class Attributes {
  final String? synopsis;
  final Map<String, dynamic>? titles;
  final String? averageRating;
  final int? userCount;
  final int? favoritesCount;
  final String? startDate;
  final String? endDate;
  final String? status;
  final Map<String, dynamic>? posterImage;

  Attributes({
    this.synopsis,
    this.titles,
    this.averageRating,
    this.userCount,
    this.favoritesCount,
    this.startDate,
    this.endDate,
    this.status,
    this.posterImage,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      synopsis: json['synopsis'],
      titles: json['titles'],
      averageRating: json['averageRating'],
      userCount: json['userCount'],
      favoritesCount: json['favoritesCount'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      posterImage: json['posterImage'],
    );
  }
}