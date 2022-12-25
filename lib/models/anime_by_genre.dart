// To parse this JSON data, do
//
//     final animeByGenre = animeByGenreFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AnimeByGenre> animeByGenreFromJson(String str) => List<AnimeByGenre>.from(
    json.decode(str).map((x) => AnimeByGenre.fromJson(x)));

String animeByGenreToJson(List<AnimeByGenre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnimeByGenre {
  AnimeByGenre({
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

  factory AnimeByGenre.fromJson(Map<String, dynamic> json) => AnimeByGenre(
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
