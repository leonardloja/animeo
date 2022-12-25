// To parse this JSON data, do
//
//     final popularAnime = popularAnimeFromJson(jsonString);

import 'dart:convert';

List<PopularAnime> popularAnimeFromJson(String str) => List<PopularAnime>.from(
    json.decode(str).map((x) => PopularAnime.fromJson(x)));

String popularAnimeToJson(List<PopularAnime> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularAnime {
  PopularAnime({
    required this.animeId,
    required this.animeTitle,
    required this.animeImg,
    required this.releasedDate,
    required this.animeUrl,
  });

  String animeId;
  String animeTitle;
  String animeImg;
  String releasedDate;
  String animeUrl;

  factory PopularAnime.fromJson(Map<String, dynamic> json) => PopularAnime(
        animeId: json["animeId"],
        animeTitle: json["animeTitle"],
        animeImg: json["animeImg"],
        releasedDate: json["releasedDate"],
        animeUrl: json["animeUrl"],
      );

  Map<String, dynamic> toJson() => {
        "animeId": animeId,
        "animeTitle": animeTitle,
        "animeImg": animeImg,
        "releasedDate": releasedDate,
        "animeUrl": animeUrl,
      };
}
