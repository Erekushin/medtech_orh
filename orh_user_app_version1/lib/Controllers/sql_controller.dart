import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Models/result.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../Helpers/logging.dart';
import '../Models/TreatmentRecipe/fields.dart';
import '../Models/TreatmentRecipe/treatment_recipe.dart';
import '../global_constant.dart';
import 'package:flutter/material.dart';
import '../Models/result.dart';

class SqlController extends GetxController{
  TreatmentRecipies treatmentRecipies = TreatmentRecipies();
  GeneralResponse generalResponse = GeneralResponse();
  var recipeList = Result().recipies.obs;
  final ereklog = logger(SqlController);
  static Database? _database;

  ///base шалгах хоосон бол үүсгэх function дуудна.
  Future get database async {
    if (_database == null){
      await initDB('medtechBase.db');
    }
    else{
      ereklog.d(_database!.path.toString());
    };
  }
  ///file ийн зам болон үүсгэх бүтэцийг аваад base ийг үүсгэнэ
  Future initDB(String filePath) async {
    final dbPath = await _localPath;
    final path = join(dbPath, filePath);
    try{
     _database = await openDatabase(path, version: 1, onCreate: _createDB);
    }
    catch(e){
      ereklog.e(e); 
    }
  }
  ///path provider ийн getExternalStorageDirectory дээрх замийг авч байгаа
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }
  ///table ийн бүтэц
  Future _createDB(Database db, int version) async {
    var table = SqlRelated.recipeTable;
    await db.execute('''
  CREATE TABLE $table ( 
  'id' INTEGER PRIMARY KEY AUTOINCREMENT, 
  'text' TEXT NOT NULL,
  'color' INTEGER NOT NULL,
  'title' TEXT NOT NULL,
  'dateStart' TEXT NOT NULL,
  'dateEnd' TEXT NOT NULL,
  'picture' TEXT NOT NULL,
  'personId' TEXT NOT NULL
  )
''');
  }
  ///push data to local
  Future create(Recipies recipe) async {
    await database;
    log(jsonEncode(recipe.toJson()));
    await _database!.insert(SqlRelated.recipeTable, recipe.toJson());
  }
  ///get all data from local
  Future readAllNotes() async {
    await database;
    // final orderBy = '${RecipeFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    try{
        final result = await _database!.query(SqlRelated.recipeTable);
        recipeList.value = result.map((json) => Recipies.fromJson(json)).toList();
        log(jsonEncode(result));
        print('sql data:' + recipeList.value!.length.toString());
    }
    catch(e){
      ereklog.d(e);
    }
  }

  Future<Recipies> readNote(int id) async {
    await database;
    final maps = await _database!.query(
      SqlRelated.recipeTable,
      columns: RecipeFields.values,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Recipies.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateData(Recipies recipe, int id) async {
    ereklog.wtf(recipe.toJson());
    var data = {'text' : recipe.text, 'color' : recipe.color, 'title':recipe.title, 'dateStart':recipe.dateStart, 
    'dateEnd':recipe.dateEnd, 'picture':recipe.picture, 'personId':recipe.personId};
    await database;
    return _database!.update(
      SqlRelated.recipeTable,
      data,
      where: '${RecipeFields.id} = $id',
    );
  }

  Future<int> delete(int id) async {
    await database;

    return await _database!.delete(
      SqlRelated.recipeTable,
      where: '${RecipeFields.id} = $id',
    );
  }

  Future close() async {
    await database;
    _database!.close();
  }




  final Map<String, dynamic> testBody = <String, dynamic>{'h':'fgfg'};
  Future doctorTestget() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(testBody, "202859", UriAdresses.backtestrui);
    generalResponse = GeneralResponse.fromJson(jsonDecode(data.toString()));
    ereklog.wtf(generalResponse.code);
    switch(generalResponse.code){
      case '100':
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.only(left: 5, top: 5, bottom: 75));
          break;
      case '101': 
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          break;
        default : break;  
    }
  }
}
