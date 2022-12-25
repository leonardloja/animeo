import 'package:animeo/models/anime_by_genre.dart';
import 'package:get/get.dart';
import '../services/remote_service.dart';

class GenreController extends GetxController {
  var showLoading = true.obs;
  RxList<AnimeByGenre>? actionResults = <AnimeByGenre>[].obs;
  RxList<AnimeByGenre>? adventureResults = <AnimeByGenre>[].obs;
  RxList<AnimeByGenre>? comedyResults = <AnimeByGenre>[].obs;
  RxList<AnimeByGenre>? fantasyResults = <AnimeByGenre>[].obs;
  RxList<AnimeByGenre>? romanceResults = <AnimeByGenre>[].obs;
  RxList<AnimeByGenre>? sportsResults = <AnimeByGenre>[].obs;

  void fetchAnimeByGenre(String genre) async {
    if (genre == 'action') {
      actionResults?.value = await RemoteService().getAnimeByGenre(genre);
      if (actionResults != null) {
        showLoading.value = false;
      }
    }
    if (genre == 'adventure') {
      adventureResults?.value = await RemoteService().getAnimeByGenre(genre);
      if (adventureResults != null) {
        showLoading.value = false;
      }
    }
    if (genre == 'comedy') {
      comedyResults?.value = await RemoteService().getAnimeByGenre(genre);
      if (comedyResults != null) {
        showLoading.value = false;
      }
    }

     if (genre == 'fantasy') {
      fantasyResults?.value = await RemoteService().getAnimeByGenre(genre);
      if (fantasyResults != null) {
        showLoading.value = false;
      }
    }

    if (genre == 'romance') {
      romanceResults?.value = await RemoteService().getAnimeByGenre(genre);
      if (romanceResults != null) {
        showLoading.value = false;
      }
    }
    if (genre == 'sports') {
      sportsResults?.value = await RemoteService().getAnimeByGenre(genre);
      if (sportsResults != null) {
        showLoading.value = false;
      }
    }

  }
}
