import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/sample_1/hive_repository.dart';
import 'package:hive_sample/sample_1/home_page.dart';

Future main() async {
  // Hive 初期化
  await Hive.initFlutter();

  // Boxインスタンスの取得
  intBox = await hiveRepository.openIntBox();
  boolBox = await hiveRepository.openBoolBox();
  listBox = await hiveRepository.openListBox();
  mapBox = await hiveRepository.openMapBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

