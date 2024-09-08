
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.date.value.isEmpty
                            ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                            : 'Selected Date: ${controller.date.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => controller.datePicker(context),
                    ),
                  ],
                )),

            Obx(() => controller.loading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.image.value.hdurl != null
                    ? SizedBox(
                        height: 300,
                        child: Image.network(
                          controller.image.value.hdurl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(child: Text('No image available'))),

            const SizedBox(height: 20), // Add spacing between the image and button

            // Submit button
            ElevatedButton(onPressed: () => controller.fetchData(), child: const Text('Search')),
          ],
        ),
      ),
    );
  }
}
