import 'package:flutter/material.dart';

import '../model/ItemModel.dart';

/*
 * This should be app main activity to display all the items posted.
 */
class ItemDisplayPage extends StatefulWidget {
  const ItemDisplayPage({Key? key}) : super(key: key);

  @override
  State<ItemDisplayPage> createState() => _ItemDisplayPageState();
}

class _ItemDisplayPageState extends State<ItemDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyper Garage Sale'),
      ),
      body: Center(
        child: FutureBuilder(
          future: ItemModel.readAll(), //callback to receive new passed in item
          builder: (context, snapshot) {
            if (snapshot.hasData == false ||
                snapshot.data == null ||
                snapshot.data == '') {
              return const Text(
                  'No items found. \nPlease clock on + button to add new item.');
            } // check if snapshot contains data

            var _tempItemInfoList = snapshot.data as List<Info>;
            print("Temporary Info List count => " +
                _tempItemInfoList.length.toString());

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _tempItemInfoList[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              _tempItemInfoList[index].price,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              _tempItemInfoList[index].description,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount:
                  _tempItemInfoList == null ? 0 : _tempItemInfoList.length,
            );
          }, // builder
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/postNewItem');
        },
        tooltip: 'Post New Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
