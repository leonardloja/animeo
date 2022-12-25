// To parse this JSON data, do
//
//     final topAiringAnime = topAiringAnimeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TopAiringAnime> topAiringAnimeFromJson(String str) => List<TopAiringAnime>.from(json.decode(str).map((x) => TopAiringAnime.fromJson(x)));

String topAiringAnimeToJson(List<TopAiringAnime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopAiringAnime {
  TopAiringAnime({
     required this.animeId,
     required this.animeTitle,
     required this.animeImg,
     required this.latestEp,
     required this.animeUrl,
     required this.genres,
  });

  String animeId;
  String animeTitle;
  String animeImg;
  String latestEp;
  String animeUrl;
  List<String> genres;

  factory TopAiringAnime.fromJson(Map<String, dynamic> json) => TopAiringAnime(
    animeId: json["animeId"],
    animeTitle: json["animeTitle"],
    animeImg: json["animeImg"],
    latestEp: json["latestEp"],
    animeUrl: json["animeUrl"],
    genres: List<String>.from(json["genres"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "animeId": animeId,
    "animeTitle": animeTitle,
    "animeImg": animeImg,
    "latestEp": latestEp,
    "animeUrl": animeUrl,
    "genres": List<dynamic>.from(genres.map((x) => x)),
  };
}
