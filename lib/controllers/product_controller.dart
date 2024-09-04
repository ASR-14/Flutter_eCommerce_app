import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/models/category_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    // print("1111");
    // print(s.length);
    // print(s[0].subcategory.length);
    // print(s[0].name);
    // print(s.runtimeType);
    for (var e in s[0].subcategory) {
      subcat.add(e);
      // print(e);
    }
  }
}
