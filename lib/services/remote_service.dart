import 'package:animeo/models/anime_by_genre.dart';
import 'package:animeo/models/anime_search.dart';
import 'package:animeo/models/popular_anime.dart';
import 'package:animeo/models/recent_release_anime.dart';
import 'package:animeo/models/top_airing_anime.dart';
import 'package:http/http.dart' as http;

import '../models/anime_details.dart';
import '../models/anime_streaming_link.dart';

class RemoteService {
  Future<List<PopularAnime>> getPopularAnime() async {
    var client = http.Client();
    var uri = Uri.parse('https://gogoanime.consumet.org/popular');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return popularAnimeFromJson(json);
    } else {
      return [];
      // or throw Exception('Failed to load ..');
    }
  }

  Future<List<TopAiringAnime>> getTopAiringAnime() async {
    var client = http.Client();
    var uri = Uri.parse('https://gogoanime.consumet.org/top-airing');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return topAiringAnimeFromJson(json);
    } else {
      return [];
      // or throw Exception('Failed to load ..');
    }
  }

  Future<List<AnimeSearch>> searchAnime(String keyword) async {
    var client = http.Client();
    var uri = Uri.parse('https://gogoanime.consumet.org/search?keyw=$keyword');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return animeSearchFromJson(json);
    } else {
      return [];
      // or throw Exception('Failed to load ..');
    }
  }

  Future<List<AnimeByGenre>> getAnimeByGenre(String genre) async {
    var client = http.Client();
    var uri = Uri.parse('https://gogoanime.consumet.org/genre/$genre');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return animeByGenreFromJson(json);
    } else {
      return [];
      // or throw Exception('Failed to load ..');
    }
  }

  Future<List<RecentReleaseAnime>> getRecentReleaseAnime() async {
    var client = http.Client();
    var uri = Uri.parse('https://gogoanime.consumet.org/recent-release');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return recentReleaseAnimeFromJson(json);
    } else {
      return [];
      // or throw Exception('Failed to load ..');
    }
  }

  Future<AnimeDetails> getAnimeDetails({required String animeID}) async {
    var client = http.Client();
    var uri =
        Uri.parse('https://gogoanime.consumet.org/anime-details/$animeID');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return animeDetailsFromJson(json);
    } else {
      throw Exception('Failed to load ..');
    }
  }

  Future<AnimeStreamingLink> getAnimeStreamingLink(
      {required String episodeID}) async {
    var client = http.Client();
    var uri =
        Uri.parse('https://api.consumet.org/anime/gogoanime/watch/$episodeID');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return animeStreamingLinkFromJson(json);
    } else {
      throw Exception('Failed to load ..');
    }
  }
}
