import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:arbtilant/Data/data_treat.dart';
import 'package:arbtilant/Controller/model_controller.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  CameraController? _camController;
  Image? image;
  String? pathDir;
  DataTreat dt = DataTreat();
  ModelController modelController = ModelController();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<String?> loadModel() async {
    await modelController.loadModel();
    return "Model loaded";
  }

  Future<void> initCamera() async {
    var cameras = await availableCameras();
    _camController = CameraController(cameras[0], ResolutionPreset.high);
    await _camController!.initialize();
  }

  Future<String> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dir = "${root.path}/TANAMAN";
    await Directory(dir).create(recursive: true);
    String filePath = "$dir/${DateTime.now().millisecondsSinceEpoch}.jpg";
    try {
      XFile img = await _camController!.takePicture();
      await img.saveTo(filePath);
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return filePath;
  }

  Future<dynamic> predict(String path) async {
    // Use ModelController for prediction
    return await modelController.runModelOnImage(path);
  }

  @override
  void dispose() {
    _camController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: initCamera(),
        builder: (_, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "SCAN TANAMAN",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          1 /
                          _camController!.value.aspectRatio,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CameraPreview(_camController!),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      if (!_camController!.value.isTakingPicture) {
                        pathDir = null;
                        pathDir = await takePicture();
                        log("hasil : $pathDir");
                        final currentContext = context;
                        if (mounted) {
                          showModalBottomSheet(
                            context: currentContext,
                            builder: (context) {
                              return FutureBuilder(
                                future: predict(pathDir!),
                                builder: (_, snap) {
                                  return (snap.connectionState ==
                                          ConnectionState.done)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 30),
                                              const Align(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                child: Text(
                                                  "Hasil Pengecekan :",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/virus.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text(
                                                    snap.data[0]['label'],
                                                    style: const TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Confidence : ${snap.data[0]['confidence']}",
                                                  style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Treatment : ",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  dt.treatment[snap
                                                      .data[0]['index']],
                                                  style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const CircularProgressIndicator();
                                },
                              );
                            },
                          );
                        }
                        setState(() {});
                      }
                    },
                    // Button
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(126, 217, 87, 1),
                      ),
                      child: const Center(
                        child: Text(
                          "PERIKSA",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
