import 'package:animeo/models/my_list.dart';
import 'package:animeo/my_list_database.dart';
import 'package:get/get.dart';

class MyListController extends GetxController {
  final list = <MyList>[].obs;

  List<MyList> get myLists => [...list];

  Future<void> loadMyListsFromDatabase() async {
    final dataList = await MyListDatabase.instance.getAllMyLists();
    print('===============================================');
    print(list.length);

    if (dataList != null) {
      list.value = dataList;
      for (var myList in list) {
        // idList.add(myList.id);
      }
    } else {
      list.value = [];
    }
  }

  void addToMyList(MyList item) {
    list.add(item);
    MyListDatabase.instance.insert(item);
  }

  void removeFromMyList(MyList item) {
    list.removeWhere((element) => element.id == item.id);
    MyListDatabase.instance.delete(item.id);
  }
}
