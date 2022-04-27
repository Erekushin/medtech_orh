// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'global_helpers.dart';



// class MyAppForCheckFilePath extends StatefulWidget {
//   const MyAppForCheckFilePath({Key? key}) : super(key: key);
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyAppForCheckFilePath> {
//   Future<Directory?>? _tempDirectory;
//   Future<Directory?>? _appSupportDirectory;
//   Future<Directory?>? _appLibraryDirectory;
//   Future<Directory?>? _appDocumentsDirectory;
//   Future<Directory?>? _externalDocumentsDirectory;
//   Future<List<Directory>?>? _externalStorageDirectories;
//   Future<List<Directory>?>? _externalCacheDirectories;
//   Future<Directory?>? _downloadsDirectory;

  

//   Widget _buildDirectory(
//       BuildContext context, AsyncSnapshot<Directory?> snapshot) {
//     Text text = const Text('');
//     if (snapshot.connectionState == ConnectionState.done) {
//       if (snapshot.hasError) {
//         text = Text('Error: ${snapshot.error}');
//       } else if (snapshot.hasData) {
//         text = Text('path: ${snapshot.data!.path}');
//       } else {
//         text = const Text('path unavailable');
//       }
//     }
//     return Padding(padding: const EdgeInsets.all(16.0), child: text);
//   }

//   Widget _buildDirectories(
//       BuildContext context, AsyncSnapshot<List<Directory>?> snapshot) {
//     Text text = const Text('');
//     if (snapshot.connectionState == ConnectionState.done) {
//       if (snapshot.hasError) {
//         text = Text('Error: ${snapshot.error}');
//       } else if (snapshot.hasData) {
//         final String combined =
//             snapshot.data!.map((Directory d) => d.path).join(', ');
//         text = Text('paths: $combined');
//       } else {
//         text = const Text('path unavailable');
//       }
//     }
//     return Padding(padding: const EdgeInsets.all(16.0), child: text);
//   }

//   void _requestTempDirectory() {
//     setState(() {
//       _tempDirectory = getTemporaryDirectory();
//     });
//   }

//   void _requestAppDocumentsDirectory() {
//     setState(() {
//       _appDocumentsDirectory = getApplicationDocumentsDirectory();
//     });
//   }

//   void _requestAppSupportDirectory() {
//     setState(() {
//       _appSupportDirectory = getApplicationSupportDirectory();
//     });
//   }

//   void _requestAppLibraryDirectory() {
//     setState(() {
//       _appLibraryDirectory = getLibraryDirectory();
//     });
//   }

//   void _requestExternalStorageDirectory() {
//     setState(() {
//       _externalDocumentsDirectory = getExternalStorageDirectory();
//     });
//   }

//   void _requestExternalStorageDirectories(StorageDirectory type) {
//     setState(() {
//       _externalStorageDirectories = getExternalStorageDirectories(type: type);
//     });
//   }

//   void _requestExternalCacheDirectories() {
//     setState(() {
//       _externalCacheDirectories = getExternalCacheDirectories();
//     });
//   }

//   void _requestDownloadsDirectory() {
//     setState(() {
//       _downloadsDirectory = getDownloadsDirectory();
//     });
//   }
//   Future<File> get _localFile async {
//   final path = await GlobalHelpers.directoryPath.tempdirectoryGet!.path;
//   return File('$path');
//   }
//   Future<File> writeCounter(String counter) async {
//   final file =  await _localFile;
//   file.writeAsStringSync('erekushin is awesome');
//   // Write the file
//   return file;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: Center(
//         child: ListView(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: const Text(
//                       'Get Temporary Directory',
//                     ),
//                     onPressed: _requestTempDirectory,
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _tempDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: const Text(
//                       'Get Application Documents Directory',
//                     ),
//                     onPressed: _requestAppDocumentsDirectory,
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _appDocumentsDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: const Text(
//                       'Get Application Support Directory',
//                     ),
//                     onPressed: _requestAppSupportDirectory,
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _appSupportDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: Text(
//                       Platform.isAndroid
//                           ? 'Application Library Directory unavailable'
//                           : 'Get Application Library Directory',
//                     ),
//                     onPressed:
//                         Platform.isAndroid ? null : _requestAppLibraryDirectory,
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _appLibraryDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: Text(
//                       !Platform.isAndroid
//                           ? 'External storage is unavailable'
//                           : 'Get External Storage Directory',
//                     ),
//                     onPressed: !Platform.isAndroid
//                         ? null
//                         : _requestExternalStorageDirectory,
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _externalDocumentsDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: Text(
//                       !Platform.isAndroid
//                           ? 'External directories are unavailable'
//                           : 'Get External Storage Directories',
//                     ),
//                     onPressed: !Platform.isAndroid
//                         ? null
//                         : () {
//                             _requestExternalStorageDirectories(
//                               StorageDirectory.music,
//                             );
//                           },
//                   ),
//                 ),
//                 FutureBuilder<List<Directory>?>(
//                   future: _externalStorageDirectories,
//                   builder: _buildDirectories,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: Text(
//                       !Platform.isAndroid
//                           ? 'External directories are unavailable'
//                           : 'Get External Cache Directories',
//                     ),
//                     onPressed: !Platform.isAndroid
//                         ? null
//                         : _requestExternalCacheDirectories,
//                   ),
//                 ),
//                 FutureBuilder<List<Directory>?>(
//                   future: _externalCacheDirectories,
//                   builder: _buildDirectories,
//                 ),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: Text(
//                       Platform.isAndroid || Platform.isIOS
//                           ? 'Downloads directory is unavailable'
//                           : 'Get Downloads Directory',
//                     ),
//                     onPressed: Platform.isAndroid || Platform.isIOS
//                         ? null
//                         : _requestDownloadsDirectory,
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _downloadsDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//              Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     child: Text(
//                       'shine file',
//                     ),
//                     onPressed: () async{
//                       Permission.storage.request();
//                       // Permission.manageExternalStorage.request();
//                       print('ddfdfddf');
//                       GlobalHelpers.directoryPath.requestTempDirectory();
//                       if(await GlobalHelpers.directoryPath.tempdirectoryGet!.exists()){
//                            print('file baih shig bna button oos shalgav');
//                            writeCounter('d');
//                            print('yum bichsenii daraa');
//                       }
//                       else{
//                            GlobalHelpers.directoryPath.tempdirectoryGet!.create(recursive: true);
//                            print('file iig vvsgechihshig bolloo gehdee button oos' + GlobalHelpers.directoryPath.tempdirectoryGet.toString());
//                           }
//                       },
//                   ),
//                 ),
//                 FutureBuilder<Directory?>(
//                   future: _downloadsDirectory,
//                   builder: _buildDirectory,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import 'package:path_provider/path_provider.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Reading and Writing Files',
//       home: FlutterDemo(storage: CounterStorage()),
//     ),
//   );
// }

class CounterStorage {
  //os iin ogch bgaa path iig avch bgaa
  
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({Key? key,}) : super(key: key);
  Future<String> get _localPath async {
    final directory = await getDownloadsDirectory();
    return directory!.path;
  }
  //avsan path deeree file iinhaa neriig nemeed file helbertei bolgoj bgaa
  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/counter.txt');
  }
  //write
  Future<File> writeCounter(String counter) async {
    final file = await _localFile;
    print(file.path + "file path is here");
    // Write the file
    return file.writeAsString('erek was here' + counter);
  }
  // read
  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'something is wrong';
    }
  }

  

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  String readData = 'empty';
  @override
  void initState(){
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
          readData,
        ),
        ElevatedButton(onPressed: (){
          GlobalHelpers.workWithLocal.writeToLog('something wonderfull gonna happen');
          print('value is put');
          }, child: Text('put data')),
        ElevatedButton(onPressed: ()async{
          if(await File(await GlobalHelpers.workWithLocal.logPath + "/Log.txt").exists()){
            GlobalHelpers.workWithLocal.readFromLog().then((String value) {
            setState(() {
            print(value + " " + "this is data which i am looking for");
            readData = value;
            });
           }); 
          }
          else{
            print('file maani bhgu bna');
          }
          }, child: Text('get data'))
          ],
        )
      ),
      
    );
  }
}