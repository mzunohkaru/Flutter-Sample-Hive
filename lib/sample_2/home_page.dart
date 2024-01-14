import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/sample_2/hive_service.dart';
import 'package:hive_sample/sample_2/person.dart';

class HomePage extends HookWidget {
  final HiveService _hiveService = HiveService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final ageController = useTextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 26, 184),
      appBar: AppBar(title: const Text('Hive Sample')),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.network(
            'https://avatars.githubusercontent.com/u/55202745?s=200&v=4',
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (nameController.text.isEmpty ||
                            ageController.text.isEmpty) return;

                        _hiveService.addItem(Person(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            man: false));

                        nameController.clear();
                        ageController.clear();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Person>('personBox').listenable(),
                      builder: (BuildContext context, Box<Person> box, _) {
                        return ListView.builder(
                          itemCount: box.length,
                          itemBuilder: (BuildContext context, int index) {
                            Person? person = box.getAt(index);

                            return ListTile(
                              leading: Switch(
                                value: person!.man,
                                onChanged: (value) {
                                  _hiveService.updateItem(index, person);
                                },
                              ),
                              title: Text(person.name),
                              subtitle: Text(person.age.toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  _hiveService.deleteItem(index);
                                },
                              ),
                            );
                          },
                        );
                      }),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _hiveService.deleteAllItems();
            },
            icon: const Icon(Icons.delete),
            label: const Text('Delete All'),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
