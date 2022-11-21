import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vajra/utils/app_utils.dart';

class CameraScreen extends StatefulWidget {
  final Object? arguments;

  const CameraScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  bool isInitialized = false;

  var visitId = '';
  var path = '';
  var screen = '';

  bool isImageCaptured = false;

  late final arguments;
  
  late Function callback;
  late String callbackName;

  @override
  void initState() {
    startCamera(0);

    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      if (arguments.containsKey('visitId')) {
        setState(() {
          visitId = arguments['visitId'];
        });
      }
      if (arguments.containsKey('path')) {
        setState(() {
          path = arguments['path'];
        });
      }
      if (arguments.containsKey('screen')) {
        setState(() {
          screen = arguments['screen'];
        });
      }
      if (arguments.containsKey('callback')) {
        setState(() {
          callback = arguments['callback'];
        });
      }
      if (arguments.containsKey('callback_name')) {
        setState(() {
          callbackName = arguments['callback_name'];
        });
      }
    }

    if (isInitialized) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                cancelImage();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.black26,
          body: !isImageCaptured
              ? Stack(
                  children: [
                    Center(
                      child: CameraPreview(cameraController),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          direction = direction == 0 ? 1 : 0;
                        });
                        startCamera(direction);
                      },
                      child: cameraButton(
                          Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
                    ),
                    GestureDetector(
                      onTap: () {
                        cameraController.takePicture().then((file) {
                          if (mounted) {
                            File f = File(path);
                            file.saveTo(f.path);
                            setState(() {
                              isImageCaptured = true;
                            });
                          }
                        });
                      },
                      child: cameraButton(
                          Icons.camera_alt_rounded, Alignment.bottomCenter),
                    )
                  ],
                )
              : Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Continue with this image?',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          child: Image.file(
                            File(path),
                            fit: BoxFit.contain,
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cancelImage();
                              },
                              child: cameraButton(
                                  Icons.close, Alignment.bottomRight),
                            ),
                            GestureDetector(
                              onTap: () {
                                File file = File(path);
                                //saveImageToDb(file);
                                callback(callbackName,file.path.split(Platform.pathSeparator).last,file.path);
                                Navigator.pop(context);
                              },
                              child: cameraButton(
                                  Icons.check, Alignment.bottomLeft),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
    } else {
      return Container();
    }
  }

  void startCamera(direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      //To refresh widget
      setState(() {
        isInitialized = true;
      });
    }).catchError((e) {
      AppUtils.showMessage(e.toString());
    });
  }

  cameraButton(IconData icon, Alignment alignment) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: alignment,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            size: 32,
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(2, 2), blurRadius: 10)
              ]),
        ),
      ),
    );
  }



  void cancelImage() {
    if (path.isNotEmpty) {
      File file = File(path);
      file.delete();
    }
    setState(() {
      isImageCaptured = false;
    });
  }
}
