// import 'dart:html' as web;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as PickImage;
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Counter extends ChangeNotifier {
  int value = 0;
  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
    value--;
    notifyListeners();
  }
}

class ImagePick extends ChangeNotifier {
  final PickImage.ImagePicker _picker = PickImage.ImagePicker();
  File? imageFile;
  RxString path = ''.obs;
  Uint8List? imagebytes;
  Uint8List? croppedData;

  Future<void> pickImage(BuildContext context, ImageSource imageSource) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: imageSource,
      );
      if (pickedFile != null) {
        imageFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          // aspectRatioPresets: [CropAspectRatioPreset.orginal],
          // maxWidth: MediaQuery.of(context).size.width.toInt(),
          androidUiSettings: const AndroidUiSettings(
            // hideBottomControls: true,
            lockAspectRatio: false,
          ),
        );
        Navigator.pop(context, true);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString() + ':::::::::::::::::::');
    }
  }

/*
  Future<void> pickImage(BuildContext context, PickImage.ImageSource imageSource) async {
    try {
      if (kIsWeb) {
        web.FileUploadInputElement uploadInput = web.FileUploadInputElement()..accept = 'image/*';
        uploadInput.click();
        uploadInput.onChange.listen((event) async {
          if (uploadInput.files != null) {
            final file = uploadInput.files!.first;
            web.FileReader reader = web.FileReader();

            reader.onLoadEnd.listen((e) {
              imagebytes = reader.result as Uint8List?;
              path.value = File.fromRawPath(imagebytes!).path;
            });
            reader.readAsArrayBuffer(file);
            Get.to(CropScreen());
          }
        });
      } else {
        final pickedFile = await _picker.pickImage(
          source: imageSource,
        );
        if (pickedFile != null) {
          path.value = pickedFile.path;
          imageFile = File(pickedFile.path);

          // crop_your_image
          imagebytes = await imageFile!.readAsBytes();
          Get.to(CropScreen());
        }
      }
    } catch (e) {
      print(e.toString() + ':::::::::::::::::::');
    }
  }

  Future<void> done() async {
*//*    final renderObject = cropperKey.currentContext!.findRenderObject();
    final boundary = renderObject as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData = await image.toByteData(
      format: ImageByteFormat.png,
    );
    final pngBytes = byteData?.buffer.asUint8List();*//*
    // print(";;;;;;;;;;;;;;;;;;;;;;  0");
    // final image = await controller.croppedImage();
    //
    // print(";;;;;;;;;;;;;;;;;;;;;;  1");
    // imageFile = File(image.toString());
    // print(";;;;;;;;;;;;;;;;;;;;;;  2");
    // print(imageFile);
    // path.value = imageFile!.path;
    Get.back();
  }*/
}
 */
}

class SpeechTextController extends GetxController with GetSingleTickerProviderStateMixin {
  /// image pick
  final PickImage.ImagePicker _picker = PickImage.ImagePicker();
  File? imageFile;
  RxString path = ''.obs;
  Uint8List? imagebytes;
  Uint8List? croppedData;

  Future<void> pickImage(BuildContext context, ImageSource imageSource) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: imageSource,
      );
      if (pickedFile != null) {
        imageFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          // aspectRatioPresets: [CropAspectRatioPreset.orginal],
          // maxWidth: MediaQuery.of(context).size.width.toInt(),
          androidUiSettings: const AndroidUiSettings(
            // hideBottomControls: true,
            lockAspectRatio: false,
          ),
        );
        if (imageFile != null) {
          path.value = imageFile!.path;
        }
        Navigator.pop(context, true);
      }
    } catch (e) {
      print(e.toString() + ':::::::::::::::::::');
    }
  }

  /// speech to text
  late final AnimationController animationController;
  late final Animation animation;
  RxDouble blurRadius = 0.0.obs;
  RxBool isSpiking = false.obs;
  RxString speechText = '..Speech To Text..'.obs;
  var selectedLanguage = 'en_IN'.obs;
  late final SpeechToText speechToText;
  @override
  void onInit() {
    speechToText = SpeechToText();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController.repeat(reverse: true);
    animation = Tween(begin: 1.0, end: 10.0).animate(animationController)
      ..addListener(() {
        blurRadius.value = animation.value;
        update();
      });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void listen() async {
    if (speechText.value.isNotEmpty) {
      speechText.value = '';
    } else {
      speechText.value = '..Speech To Text..';
    }
    if (!isSpiking.value) {
      bool available = await speechToText.initialize(
        onStatus: (status) {
          print(':::::::::::::::::::::::::::::::::::::; Status =>   $status');
          if (status == 'done') {
            isSpiking.value = false;
            speechToText.stop();
          }
        },
        onError: (errorNotification) {},
      );
      if (available) {
        isSpiking.value = true;
        speechToText.listen(
          onResult: (result) {
            speechText.value = result.recognizedWords;
          },
          localeId: selectedLanguage.value,
        );
      }
    } else {
      isSpiking.value = false;
      speechToText.stop();
      speechText.value = '..Speech To Text..';
    }
  }

  void onChangedLanguage(var language) {
    selectedLanguage.value = language;
    speechText.value = '..Speech To Text..';
  }
}
