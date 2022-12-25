import 'package:animeo/models/anime_search.dart';
import 'package:get/get.dart';
import '../services/remote_service.dart';

class SearchController extends GetxController {
  var showLoading = false;

  RxList<AnimeSearch>? searchAnimeResults = <AnimeSearch>[].obs;

  void fetchSearchAnime(String keyword) async {
    _updateShowLoading(true);
    searchAnimeResults?.value = await RemoteService().searchAnime(keyword);
    _updateShowLoading(false);
  }

  void _updateShowLoading(bool currentStatus) {
    showLoading = currentStatus;
    update();
  }
}
