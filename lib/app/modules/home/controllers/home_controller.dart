import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nasa/app/data/image_response.dart';
import 'package:nasa/app/repository/get_image.dart';

class HomeController extends GetxController {
  final Rx<NasaImageResponse> image = NasaImageResponse().obs;
  final loading = false.obs;
  final now=DateTime.now();
  final RxString date = ''.obs;


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      date.value = formattedDate; // Update the date value
    }
  }



  Future<void> fetchData() async {
    Map<String, dynamic> values = {};
    String currentDate = DateFormat('dd-MM-yyyy').format(now);
    try {
      loading.value = true;

      /// Call the login function
      values['api_key'] = '18QBwoiRpbFgeYBSl3PxFHi2aoJjrt7lIindJfng';
      values['date'] = date.value.isEmpty ? currentDate : date.value;
      print(date);
      await getImageApi(values).then((response) {
        if (response != null) {
          image.value = response;
        }
      });
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }
}
