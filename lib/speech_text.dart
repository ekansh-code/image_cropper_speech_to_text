import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_flutter/counter.dart';

class SpeechText extends StatelessWidget {
  final SpeechTextController _speechTextController = Get.put(SpeechTextController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Speech Text'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Text(
                _speechTextController.speechText.value,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Obx(
        () => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.greenAccent),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent,
                blurRadius: _speechTextController.isSpiking.value ? _speechTextController.blurRadius.value : 0,
                spreadRadius: _speechTextController.isSpiking.value ? _speechTextController.blurRadius.value : 0,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              _speechTextController.listen();
              // Future.delayed(const Duration(seconds: 3), () => _speechTextController.isSpiking.value = false);
            },
            icon: const Icon(Icons.mic),
          ),
        ),
      ).paddingSymmetric(horizontal: Get.width / 2.5),
    );
  }
}
