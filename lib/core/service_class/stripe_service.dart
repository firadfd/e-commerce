import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_caller/repository/network_caller.dart';
import 'network_caller/utility/app_urls.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<String?> GetToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userToken");
  }

  Future<SubscriptionResponse> setupPaymentMethod1(String priceId) async {
    try {
      String? setupIntentClientSecret = await _createSetupIntent();
      if (setupIntentClientSecret == null) {
        log('Setup Intent creation failed');
        return SubscriptionResponse(status: false);
      }

      log('Setup Intent Created: $setupIntentClientSecret');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setupIntentClientSecret,
          merchantDisplayName: "DANCEFLUENCER",
        ),
      );

      return await _confirmSetupIntent(setupIntentClientSecret, priceId);
    } catch (e) {
      log('Setup Failed: $e');
      return SubscriptionResponse(status: false);
    }
  }

  Future<SubscriptionResponse> _confirmSetupIntent(
    String setupIntentClientSecret,
    String priceId,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      log('Setup Successful!');
      return await _getSetupDetails(setupIntentClientSecret, priceId);
    } catch (e) {
      log('Setup Confirmation Failed: $e');
      return SubscriptionResponse(status: false);
    }
  }

  Future<SubscriptionResponse> _getSetupDetails(
    String setupIntentClientSecret,
    String priceId,
  ) async {
    try {
      final Dio dio = Dio();
      final setupIntentId = setupIntentClientSecret.split('_secret')[0];
      log('Setup Intent ID: $setupIntentId');

      var response = await dio.get(
        "https://api.stripe.com/v1/setup_intents/$setupIntentId",
        options: Options(
          headers: {
            "Authorization":
                "Bearer sk_test_51RLGHnHDdO1S05AmT0jmArZO4P5AJ0m2TprQJ5tpL1pixpL9o4FI078iOMU4vcZgAcxIn937ZjTVH9fQuzx1digK00hjGwXBq9",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.data != null && response.data['payment_method'] != null) {
        String paymentMethodId = response.data['payment_method'];
        log('Payment Method ID: $paymentMethodId');
        return await createRoom(paymentMethodId, priceId);
      } else {
        log('No payment method returned from Stripe');
        return SubscriptionResponse(status: false);
      }
    } catch (e) {
      log('Failed to retrieve setup details: $e');
      return SubscriptionResponse(status: false);
    }
  }

  Future<SubscriptionResponse> createRoom(String paymentMethodId, String priceId) async {
    try {
      String? token = await GetToken();
      final url = AppUrls.subscriptionUrl;

      final body = {"paymentMethodId": paymentMethodId, "priceId": priceId};

      final response = await NetworkCaller().postRequest(
        url,
        body: body,
        token: token,
      );

      if (response.statusCode == 201) {
        final userSubscriptionId = response.responseData['userSubscriptionId'] as String?;
        final isFamilyPlan = response.responseData['isFamilyPlan'] as bool?;

        log('userSubscriptionId: $userSubscriptionId');
        log('isFamilyPlan: $isFamilyPlan');

        return SubscriptionResponse(
          status: true,
          userSubscriptionId: userSubscriptionId,
          isFamilyPlan: isFamilyPlan,
        );
      } else {
        log("API Failure: ${response.errorMessage}");
        return SubscriptionResponse(status: false);
      }
    } catch (error) {
      log("createRoom Error: $error");
      return SubscriptionResponse(status: false);
    }
  }



  Future<String?> _createSetupIntent() async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {"payment_method_types[]": "card"};
      var response = await dio.post(
        "https://api.stripe.com/v1/setup_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization":
                "Bearer sk_test_51RLGHnHDdO1S05AmT0jmArZO4P5AJ0m2TprQJ5tpL1pixpL9o4FI078iOMU4vcZgAcxIn937ZjTVH9fQuzx1digK00hjGwXBq9",
          },
        ),
      );

      if (response.data != null) {
        log('Setup Intent Response: ${response.data}');
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      log('Error creating SetupIntent: $e');
      return null;
    }
  }

  Future<({bool success, String? paymentMethodId, String? errorMessage})> addCard() async {
    try {
      String? setupIntentClientSecret = await _createSetupIntent();
      if (setupIntentClientSecret == null) {
        log('Failed to create Setup Intent for adding card.');
        return (success: false, paymentMethodId: null, errorMessage: 'Failed to create Setup Intent. Please try again.');
      }
      log('Setup Intent Client Secret for adding card: $setupIntentClientSecret');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setupIntentClientSecret,
          merchantDisplayName: "DANCEFLUENCER",
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      log('Card details collected successfully!');

      final Dio dio = Dio();
      final setupIntentId = setupIntentClientSecret.split('_secret')[0];
      log('Setup Intent ID after presenting sheet: $setupIntentId');

      var response = await dio.get(
        "https://api.stripe.com/v1/setup_intents/$setupIntentId",
        options: Options(
          headers: {
            "Authorization":
            "Bearer sk_test_51RLGHnHDdO1S05AmT0jmArZO4P5AJ0m2TprQJ5tpL1pixpL9o4FI078iOMU4vcZgAcxIn937ZjTVH9fQuzx1digK00hjGwXBq9",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      log('Response Status from getting SetupIntent details: ${response.statusCode}');
      log('Response Data from getting SetupIntent details: ${response.data}');

      if (response.data != null && response.data['payment_method'] != null) {
        String paymentMethodId = response.data['payment_method'];
        log('Successfully retrieved Payment Method ID: $paymentMethodId');
        return (success: true, paymentMethodId: paymentMethodId, errorMessage: null);
      } else {
        log('No payment method found in the SetupIntent response.');
        return (success: false, paymentMethodId: null, errorMessage: 'Card added, but payment method ID could not be retrieved.');
      }
    } on StripeException catch (e) {
      log('Stripe error when adding card: ${e.error.code} - ${e.error.message}');
      return (success: false, paymentMethodId: null, errorMessage: e.error.message ?? 'An unexpected Stripe error occurred.');
    } catch (e) {
      log('Error adding card: $e');
      return (success: false, paymentMethodId: null, errorMessage: 'An unexpected error occurred while adding the card: $e');
    }
  }

}

class SubscriptionResponse {
  final bool status;
  final String? userSubscriptionId;
  final bool? isFamilyPlan;

  SubscriptionResponse({
    required this.status,
    this.userSubscriptionId,
    this.isFamilyPlan,
  });
}

