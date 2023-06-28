import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:currency_exchanger_with_getx/app/utilities/GlobalVariebles.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString title = 'Convert'.obs;
  RxString selectedCurrency = 'USD'.obs;
  RxString secondSelectedCurrency = 'USD'.obs;
  RxList currencyList = [].obs;
  RxString apiKey = GlobalVariebles.apiKey.obs;
  TextEditingController amountController = TextEditingController();

  // function to get all the codes for the currencies
  Future<List<String>> getAvailableCurrencies() async {
    final url = 'https://v6.exchangerate-api.com/v6/$apiKey/codes';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<String> currencies = [];
      for (var currency in data['supported_codes']) {
        currencyList.add(currency);
      }

      return currencies;
    } else {
      throw Exception('Failed to fetch currencies');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    getAvailableCurrencies();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
