import 'package:e_commerce/features/home/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/helper/shared_prefarenses_helper.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/service_class/network_caller/utility/app_urls.dart';

class HomeScreenController extends GetxController {
  SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
  RxList<Product> historyList = <Product>[].obs;
  RxString errorMessage = "".obs;

  @override
  Future<void> onInit() async {
    await sharedPreferencesHelper.init();
    getProduct();
    super.onInit();
  }

  Future<void> getProduct() async {
    try {
      EasyLoading.show(status: 'Loading Product...');
      final response = await NetworkCaller().getRequest(AppUrls.product);
      if (response.isSuccess) {
        final List<dynamic> resultArray = response.responseData;
        if (resultArray.isEmpty) {
          errorMessage.value = "No product found";
        } else {
          historyList.clear();
          historyList.addAll(resultArray
              .whereType<Map<String, dynamic>>()
              .map((item) => Product.fromJson(item))
              .toList());
          debugPrint("Error in getProduct: ${historyList.length}");
        }
      } else {
        errorMessage.value = response.errorMessage;
        Get.snackbar(
          "Error",
          response.errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error in getProduct: $e");
      Get.snackbar(
        "Exception",
        "Something went wrong while fetching products.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

}
