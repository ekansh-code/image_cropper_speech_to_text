import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_flutter/counter.dart';

class CropScreen extends StatelessWidget {
  ImagePick imagePick = Get.find();
  final _transformationController = TransformationController(); // RepaintBoundary
  final cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
      ),
      body: Obx(
        () => imagePick.path.value != ''
            ? Center(
                child: Crop(
                  image: imagePick.imagebytes!,
                  controller: cropController,
                  onCropped: (image) {
                    imagePick.croppedData = image;
                    imagePick.path.value = File.fromRawPath(image).path;
                  },
                ),

                // RepaintBoundary(
                //   key: imagePick.cropperKey,
                //   child: LayoutBuilder(
                //     builder: (context, constraints) {
                //       return InteractiveViewer(
                //         minScale: 0.1,
                //         transformationController: _transformationController,
                //         constrained: false,
                //         child: Builder(
                //           builder: (context) {
                //             return Image.file(
                //               File(imagePick.path.value),
                //             );
                //           },
                //         ),
                //       );
                //     },
                //   ),
                // ),

                // CropImage(
                //   gridColor: Colors.red,
                //   image: Image.file(
                //     File(imagePick.path.value),
                //   ),
                // ),
              )
            : const SizedBox(),
      ),
      bottomNavigationBar: _buildButtons(),
    );
  }

  Widget _buildButtons() => ButtonBar(
        // alignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              cropController.crop();
              Get.back();
            }, // imagePick.finished,
            icon: const Icon(Icons.done),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: Get.back,
          ),
          // IconButton(
          //   icon: const Icon(Icons.aspect_ratio),
          //   onPressed: imagePick.aspectRatios,
          // ),
        ],
      );
}
