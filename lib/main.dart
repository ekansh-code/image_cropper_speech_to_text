import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChangeNotifierProvider<ImagePick>(
        create: (context) => ImagePick(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    //  final imagePick = Provider.of<ImagePick>(context, listen: false);
    final SpeechTextController _speechTextController = Get.put(SpeechTextController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change profile picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Stack(
              children: [
                // Consumer<ImagePick>(
                //   builder: (context, value, child) => imagePick.imageFile != null
                //       ? CircleAvatar(
                //           backgroundImage: FileImage(imagePick.imageFile!),
                //           radius: 80,
                //         )
                //       : const CircleAvatar(
                //           backgroundImage: AssetImage('assets/ram_image.jpg'),
                //           radius: 80,
                //         ),
                // ),
                Obx(
                  () => _speechTextController.path.value != '' && _speechTextController.imageFile != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(_speechTextController.path.value)),
                          radius: 80,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage('assets/ram_image.jpg'),
                          radius: 80,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        elevation: 2,
                        context: context,
                        builder: (context) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.start,
                            buttonPadding: const EdgeInsets.all(20),
                            children: [
                              FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  _speechTextController.pickImage(context, ImageSource.camera);
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                              FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  _speechTextController.pickImage(context, ImageSource.gallery);
                                },
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Image picker',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 1.0),
                    ),
                    child: Obx(
                      () => Text(
                        _speechTextController.speechText.value,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      // border: Border.all(color: Colors.greenAccent),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: _speechTextController.isSpiking.value ? _speechTextController.blurRadius.value : 0,
                          spreadRadius: _speechTextController.isSpiking.value ? _speechTextController.blurRadius.value : 0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: _speechTextController.listen,
                      icon: const Icon(Icons.mic),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            languageLabel('Select your local language', color: Colors.blueGrey),
            Obx(
              () => Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'hi_IN',
                        groupValue: _speechTextController.selectedLanguage.value,
                        onChanged: (value) {
                          _speechTextController.onChangedLanguage(value);
                          print(value);
                        },
                      ),
                      languageLabel('Hindi'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'gu_IN',
                        groupValue: _speechTextController.selectedLanguage.value,
                        onChanged: (value) {
                          _speechTextController.onChangedLanguage(value);
                          print(value);
                        },
                      ),
                      languageLabel('Gujarati'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'en_IN',
                        groupValue: _speechTextController.selectedLanguage.value,
                        onChanged: (value) {
                          _speechTextController.onChangedLanguage(value);
                          print(value);
                        },
                      ),
                      languageLabel('English'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text languageLabel(String language, {Color? color}) {
    return Text(
      language,
      style: TextStyle(color: color ?? Colors.green, fontWeight: FontWeight.bold),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_flutter/counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ImagePick imagePick = Get.put(ImagePick());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change profile picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Stack(
              children: [
                Obx(
                  () => imagePick.path.value != '' && imagePick.croppedData != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(imagePick.croppedData!), //FileImage(File(imagePick.path.value)),
                          radius: 80,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage('assets/ram_image.jpg'),
                          radius: 80,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        elevation: 2,
                        context: context,
                        builder: (context) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.start,
                            buttonPadding: const EdgeInsets.all(20),
                            children: [
                              FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  imagePick.pickImage(context, ImageSource.camera);
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                              FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  imagePick.pickImage(context, ImageSource.gallery);
                                },
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Image picker',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}*/
