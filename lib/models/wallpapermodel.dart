import 'package:flutter/foundation.dart';

class Wallpapermodel {
  String photographer;
  String phptographer_url;
  int photographer_id;
  Srcmodel src;

  Wallpapermodel(
      {required this.photographer,
      required this.photographer_id,
      required this.phptographer_url,
      required this.src});

  factory Wallpapermodel.fromMap(Map<String, dynamic> jsonData) {
    return Wallpapermodel(
        photographer: jsonData['photographer'],
        photographer_id: jsonData['photographer_id'],
        phptographer_url: jsonData['photographer_url'],
        src: Srcmodel.fromMap(jsonData['src']));
  }
}

class Srcmodel {
  String original;
  String portrait;
  String small;

  Srcmodel(
      {required this.original, required this.portrait, required this.small});

  factory Srcmodel.fromMap(Map<String, dynamic> jsonData) {
    return Srcmodel(
        original: jsonData['original'],
        portrait: jsonData['portrait'],
        small: jsonData['small']);
  }
}
