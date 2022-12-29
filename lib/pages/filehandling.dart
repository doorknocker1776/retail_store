import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class Storage{
  Future<String> get _localpath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localpath;
    return File("$path/counter.txt");
  }
  Future<int> Appender() async {
    try {
      final file = await _localFile;
      String contents =await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

}
