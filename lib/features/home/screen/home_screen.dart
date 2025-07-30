import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/service_class/stripe_service.dart';
import '../../../core/utils/app_colors.dart';
import '../controller/home_screen_controller.dart';
import '../widget/home_app_bar.dart';
import '../widget/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        name: controller.sharedPreferencesHelper.getString("name") ?? "",
        imageUrl:
            controller.sharedPreferencesHelper.getString("url") ??
            "https://firebasestorage.googleapis.com/v0/b/app-screenshot-352c0.appspot.com/o/images.png?alt=media&token=de8df7bb-6d43-4b36-82f2-82db07f5026c",
        email: controller.sharedPreferencesHelper.getString("email") ?? "",
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: Colors.black,
        onRefresh: () {
          return controller.getProduct();
        },
        child: Obx(() {
          if (controller.historyList.isEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value.isNotEmpty
                    ? controller.errorMessage.value
                    : "Loading...",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              final item = controller.historyList[index];
              return ProductCard(product: item, onBuy: () async {
                EasyLoading.show(status: "Processing Payment...");
                final stripeService = StripeService.instance;
                final response = await stripeService.setupPaymentMethod1(item.title);

                EasyLoading.dismiss();

                if (response.status) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Payment Successful"),
                      content: Text("Your purchase of ${controller.historyList[index].title} is confirmed."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text("OK"),
                        )
                      ],
                    ),
                  );
                } else {
                  Get.snackbar(
                    "Payment Failed",
                    "Unable to complete the payment. Please try again.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              });
            },
          );
        }),
      ),
    );
  }
}
