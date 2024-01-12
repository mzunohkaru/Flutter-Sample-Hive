import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/hive_repository.dart';

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
      home: const MyHomePage(title: 'Flutter Hive Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter;
  final mailController = TextEditingController();
  final nameController = TextEditingController();

  void pushCounter(int index) {
    setState(() {
      if (index == 0) {
        _counter--;
      } else {
        _counter++;
      }

      // データを保存
      hiveRepository.putInt(intBox, _counter);
    });
  }

  @override
  void initState() {
    super.initState();
    // データを取得
    _counter = hiveRepository.getInt(intBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          counterBody(),
          Switch(
            value: hiveRepository.getBool(boolBox),
            onChanged: (value) {
              setState(() {
                hiveRepository.putBool(boolBox, value);
              });
            },
          ),
          ElevatedButton(
            onPressed: saveList,
            child: Text('Save to List'),
          ),
          textfieldBody('Mail', mailController),
          textfieldBody('Name', nameController),
          ElevatedButton(
            onPressed: saveMap,
            child: Text('Save to Map'),
          ),
        ],
      ),
    );
  }

  Widget counterBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            pushCounter(0);
          },
          icon: const Icon(Icons.remove_circle),
          label: const Text("Decrease"),
        ),
        Text(
          _counter.toString(),
          style: const TextStyle(fontSize: 24),
        ),
        ElevatedButton.icon(
          onPressed: () {
            pushCounter(1);
          },
          icon: const Icon(Icons.add_circle_outlined),
          label: const Text("Increase"),
        ),
      ],
    );
  }

  Future saveList() async {
    List list = hiveRepository.getList(listBox);
    list.addAll(
        [hiveRepository.getInt(intBox), hiveRepository.getBool(boolBox)]);
    await hiveRepository.putList(listBox, list);

    showSnackBar(hiveRepository.getList(listBox).toString());
  }

  Future saveMap() async {
    Map data = {
      'mail': mailController.text,
      'name': nameController.text,
    };
    await hiveRepository.putMap(mapBox, data);

    showSnackBar(
        'メール: ${hiveRepository.getMap(mapBox)['mail']} 名前: ${hiveRepository.getMap(mapBox)['name']}');
  }

  Widget textfieldBody(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: '閉じる',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
