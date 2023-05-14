import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Widget> rootSetUp(
    {required Widget root,required Locale local}
)async {
  var path='assets/translations/${local.toStringWithSeparator(separator: "-")}.json';
  var d=json.decode(await rootBundle.loadString(path));
  return Builder(builder: (context) {
    return EasyLocalization(
        fallbackLocale: Locale('en','US'),
        startLocale: local,
        assetLoader: JsonAssetLoader(data: Map<String,dynamic>.from(d)),
        saveLocale: false,
        supportedLocales:[
          Locale('en','US'),
          Locale('fr','FR'),
        ],
        path: 'assets/translations',
      child: Builder(builder: (context){
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },),

    );
  });
}

class JsonAssetLoader extends AssetLoader {
  final Map<String, dynamic> data;
  const JsonAssetLoader({this.data = const {}});

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    return Future.value(data);
  }
}