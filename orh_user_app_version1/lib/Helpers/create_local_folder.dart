import 'dart:io';
import 'package:path_provider/path_provider.dart';
class DirectoryPath{

  Directory? tempDirectory;
  Directory? tempDirectoryFolder;
  set tempdirectorySet(Directory path){
    tempDirectory = path;
  }
  Directory? get tempdirectoryGet{
    return tempDirectoryFolder = Directory('${tempDirectory?.path}/LogFile.txt');
  }
  void requestTempDirectory() async{
    tempdirectorySet = await getTemporaryDirectory();
  }


  Directory? _appSupportDirectory;

  
  Directory? _appLibraryDirectory;
  Directory? _appDocumentsDirectory;
  Directory? _externalDocumentsDirectory;
  List<Directory>? _externalStorageDirectories;
  List<Directory>? _externalCacheDirectories;
  Directory? _downloadsDirectory;
  

  void _requestAppDocumentsDirectory() async{
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();
  }

  void _requestAppSupportDirectory() async{
    _appSupportDirectory = await getApplicationSupportDirectory();
  }

  void _requestAppLibraryDirectory() async{
    _appLibraryDirectory = await getLibraryDirectory();
  }

  void _requestExternalStorageDirectory() async{
    _externalDocumentsDirectory = await getExternalStorageDirectory();
  }

  void _requestExternalStorageDirectories(StorageDirectory type) async{
    _externalStorageDirectories = await getExternalStorageDirectories(type: type);
  }

  void _requestExternalCacheDirectories() async{
    _externalCacheDirectories = await getExternalCacheDirectories();
  }

  void _requestDownloadsDirectory() async{
    _downloadsDirectory = await getDownloadsDirectory();
  }
}