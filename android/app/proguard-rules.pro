# TensorFlow Lite GPU keep rules
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Prevent removal of Flutter plugin classes
-keep class sq.flutter.tflite.** { *; }
-dontwarn sq.flutter.tflite.**

# Keep class references used by reflection
-keep class * extends io.flutter.plugin.common.MethodChannel$MethodCallHandler { *; }

# General keep for Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**
