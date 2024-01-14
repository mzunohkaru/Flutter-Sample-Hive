import 'package:hive/hive.dart';

class HiveRepository {
  // key名
  String i = 'int';
  String b = 'bool';
  String l = 'list';
  String m = 'map';

  // box名
  String intBox = 'int_box';
  String boolBox = 'bool_box';
  String listBox = 'list_box';
  String mapBox = 'map_box';

  // boxの取得
  Future<Box> openIntBox() async {
    Box box = await Hive.openBox(intBox);
    return box;
  }

  Future<Box> openBoolBox() async {
    Box box = await Hive.openBox(boolBox);
    return box;
  }

  Future<Box> openListBox() async {
    Box box = await Hive.openBox(listBox);
    return box;
  }
  Future<Box> openMapBox() async {
    Box box = await Hive.openBox(mapBox);
    return box;
  }

  // データの取得
  int getInt(Box box) {
    return box.get(i, defaultValue: 0);
  }

  bool getBool(Box box) {
    return box.get(b, defaultValue: false);
  }

  List getList(Box box) {
    return box.get(l, defaultValue: []);
    // Box内のすべての値を取得し、それらをintのリストにキャスト
    // return box.values.toList().cast<int>();
  }

  Map getMap(Box box) {
    return box.get(m, defaultValue: {});
  }

  // データを保存
  Future putInt(Box box, int value) async {
    await box.put(i, value);
  }

  Future putBool(Box box, bool value) async {
    await box.put(b, value);
  }

  Future putList(Box box, List list) async {
    await box.put(l, list);
  }

  Future putMap(Box box, Map map) async {
    await box.put(m, map);
  }

  // データの消去
  // Future<void> clearList(Box box) async {
  //   await box.clear();
  // }
}

// HiveRepositoryのインスタンスを作成
HiveRepository hiveRepository = HiveRepository();

// Box型の変数を宣言
late Box intBox;
late Box boolBox;
late Box listBox;
late Box mapBox;
