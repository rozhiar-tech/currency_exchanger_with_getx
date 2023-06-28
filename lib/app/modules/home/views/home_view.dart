import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.title.value),
            backgroundColor: const Color(0xff090909),
            elevation: 0,
            centerTitle: true,
          ),
          backgroundColor: const Color(0xff090909),
          body: SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                color: const Color(0xffFE5707),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: const Color(0xffFE5707),
                                    value: controller.selectedCurrency.value,
                                    items: controller.currencyList
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                '${e[0]}', // Accessing both elements in the inner list
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              value: e[
                                                  0], // Using the currency code as the value
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      controller.selectedCurrency.value =
                                          value as String;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.64,
                              decoration: BoxDecoration(
                                color: const Color(0xff0F0F0F),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'From',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      onSubmitted: (value) {
                                        if (value.isEmpty) {
                                          Get.snackbar(
                                              'empty', "Please enter a value");
                                          controller.toAmountController.text =
                                              '';
                                          return;
                                        }
                                        double parsedValue = double.parse(
                                            controller.amountController.text);
                                        controller.convertCurrency(
                                            controller.selectedCurrency.value,
                                            controller
                                                .secondSelectedCurrency.value,
                                            parsedValue);
                                        controller.amountController.text =
                                            parsedValue.toString();
                                        controller.amountController.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: controller
                                                        .amountController
                                                        .text
                                                        .length));
                                      },
                                      controller: controller.amountController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        hintText:
                                            '0.00 ${controller.selectedCurrency.value}',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.25,
                              decoration: BoxDecoration(
                                color: const Color(0xffFE5707),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: const Color(0xffFE5707),
                                    value:
                                        controller.secondSelectedCurrency.value,
                                    items: controller.currencyList
                                        .map((e) => DropdownMenuItem<String>(
                                              child: Text(
                                                '${e[0]}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              value: e[0],
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      print(value);
                                      controller.secondSelectedCurrency.value =
                                          value!;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.64,
                              decoration: BoxDecoration(
                                color: const Color(0xff0F0F0F),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'To     ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: TextField(
                                      controller: controller.toAmountController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        hintText:
                                            '0.00 ${controller.secondSelectedCurrency.value}',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double parsedValue =
                          double.parse(controller.amountController.text);

                      controller.convertCurrency(
                          controller.selectedCurrency.value,
                          controller.secondSelectedCurrency.value,
                          parsedValue);
                      controller.amountController.text = parsedValue.toString();
                      controller.result.value = parsedValue.toString();
                      controller.amountController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: controller.amountController.text.length),
                      );
                    },
                    child: const Text('Convert'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffFE5707),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      minimumSize: Size(Get.width * 0.9, Get.height * 0.08),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: Get.height * 0.12,
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xff0F0F0F),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Result',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.result.value,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // number of columns
                            crossAxisSpacing: 6, // spacing between the cells
                            mainAxisSpacing: 3, // spacing between the rows
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  controller.amountController.text =
                                      '${controller.amountController.text}${index + 1}';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff181818),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}', // Displaying numbers starting from 1
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount:
                              10, // specify the number of items in the grid
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.amountController.text = '';
                            controller.toAmountController.text = '';
                            controller.result.value = '0.00';
                          },
                          child: const Text('Clear'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffFE5707),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            minimumSize:
                                Size(Get.width * 0.1, Get.height * 0.08),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
