import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/sample_2/hive_service.dart';
import 'package:hive_sample/sample_2/home_page.dart';
import 'package:hive_sample/sample_2/person.dart';

Future main() async {
  // Hive 初期化
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HiveService _hiveService = HiveService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _hiveService.getAllItems(),
        builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
