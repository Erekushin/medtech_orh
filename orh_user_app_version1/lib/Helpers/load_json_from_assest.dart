
import 'package:flutter/services.dart';

Future<String> loadFromAsset(String assetRoute) async {
      return await rootBundle.loadString(assetRoute);
}