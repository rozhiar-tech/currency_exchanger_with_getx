import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:currency_exchanger_with_getx/app/utilities/GlobalVariebles.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // state variables for the home screen
  RxString title = 'Convert'.obs;
  RxString selectedCurrency = 'USD'.obs;
  RxString secondSelectedCurrency = 'USD'.obs;
  RxList currencyList = [].obs;
  RxString apiKey = GlobalVariebles.apiKey.obs;
  RxString baseUrl = GlobalVariebles.baseUrl.obs;
  RxString result = '0.00'.obs;

  // controllers for the text fields
  TextEditingController amountController = TextEditingController();
  TextEditingController toAmountController = TextEditingController();

  // function to get all the codes for the currencies
  Future<List<String>> getAvailableCurrencies() async {
    final url = '$baseUrl$apiKey/codes';
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

  // function to convert the currency
  Future<double> convertCurrency(
      String fromCurrency, String toCurrency, double amount) async {
    final url = '$baseUrl$apiKey/pair/$fromCurrency/$toCurrency/$amount';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      double result = data['conversion_result'].roundToDouble();
      toAmountController.text = result.toString();
      return result;
    } else {
      throw Exception('Failed to convert currency');
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
