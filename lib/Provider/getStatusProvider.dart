import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/Constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';


class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getStatus(String ext) async {
    final status = await Permission.manageExternalStorage.request();

    if (status.isDenied) {
      Permission.manageExternalStorage.request();
      log("Permission denied");
      return;
    }

    if (status.isGranted) {
      final directory = Directory(AppConstants.STATUS_PATH);

      if (directory.existsSync()) {
        final items = directory.listSync();

        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }

        _isWhatsappAvailable = true;
        notifyListeners();

        log(items.toString());
      } else {
        log("No whatsapp found pn this device");
        _isWhatsappAvailable = false;
        notifyListeners();
      }
    }
  }
}