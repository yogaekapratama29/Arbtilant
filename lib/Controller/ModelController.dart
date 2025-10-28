

import 'package:tflite_v2/tflite_v2.dart';

class ModelController {

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/model.tflite",
      labels: "assets/model/labels.txt"
    );
  }

}