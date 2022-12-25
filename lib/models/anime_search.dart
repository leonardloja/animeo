// To parse this JSON data, do
//
//     final animeSearch = animeSearchFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AnimeSearch> animeSearchFromJson(String str) => List<AnimeSearch>.from(
    json.decode(str).map((x) => AnimeSearch.fromJson(x)));

String animeSearchToJson(List<AnimeSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnimeSearch {
  AnimeSearch({
    required this.animeId,
    required this.animeTitle,
    required this.animeUrl,
    required this.animeImg,
    required this.status,
  });

  String animeId;
  String animeTitle;
  String animeUrl;
  String animeImg;
  String status;

  factory AnimeSearch.fromJson(Map<String, dynamic> json) => AnimeSearch(
        animeId: json["animeId"],
        animeTitle: json["animeTitle"],
        animeUrl: json["animeUrl"],
        animeImg: json["animeImg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "animeId": animeId,
        "animeTitle": animeTitle,
        "animeUrl": animeUrl,
        "animeImg": animeImg,
        "status": status,
      };
}
