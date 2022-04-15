import 'dart:io';
import 'package:path_provider/path_provider.dart';


class WorkingWithLocal{
  //log
  Future<String> get logPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
  Future<File> get logFile async {
    final path = await logPath;
    return File('$path/Log.txt');
  }
  Future<File> writeToLog(String data) async {
    final file = await logFile;
    return file.writeAsString(data);
  }
  Future<String> readFromLog() async {
    try {
      final file = await logFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString()+'something is wrong in log';
    }
  }

  //setting Cache
  Future<String> get settingCachePath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }
  Future<File> get settingCacheFile async {
    final path = await settingCachePath;
    return File('$path/Log.txt');
  }
   Future<File> writeToSettingCache(String data) async {
    final file = await settingCacheFile;
    return file.writeAsString(data);
  }
  Future<String> readFromSettingCache() async {
    try {
      final file = await settingCacheFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString()+'something is wrong in Setting Cache';
    }
  }

  //data Cache
  Future<String> get dataCachePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get dataCacheFile async {
    final path = await dataCachePath;
    return File('$path/Log.txt');
  }
  Future<File> writeToDataCache(String data) async {
    final file = await dataCacheFile;
    return file.writeAsString(data);
  }
  Future<String> readFromDataCache() async {
    try {
      final file = await dataCacheFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString()+'something is wrong in DataCache';
    }
  }
}