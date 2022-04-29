import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/*
 * Store Firebase data
 */
class ItemPostInfo {
  ItemPostInfo(
      {required this.name,
      required this.price,
      required this.description,
      required this.path});
  final String name;
  final String price;
  final String description;
  final String path;
}

class ItemPostDetailModel {
  final ItemPostInfo textModel;
  // final Image image1;
  // final Image image2;
  // final Image image3;
  // final Image image4;
  var url1;
  var url2;
  var url3;
  var url4;

  ItemPostDetailModel(
      this.textModel, this.url1, this.url2, this.url3, this.url4);
}

/*
 * This should be app main activity to display all the items posted.
 */
class ItemDisplayPage extends StatefulWidget {
  const ItemDisplayPage({Key? key}) : super(key: key);
  // const ItemDisplayPage({required this.messages});
  // final List<ItemPostInfo> messages; // new

  @override
  State<ItemDisplayPage> createState() => _ItemDisplayPageState();
}

class _ItemDisplayPageState extends State<ItemDisplayPage> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<ItemPostInfo>;
    // print('length');
    // print(arguments.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyper Garage Sale'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: arguments.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () async {
                  final imagePath = arguments[index].path;
                  final imagePath1 = 'images' + imagePath + "/_image1";
                  final ref1 = FirebaseStorage.instance.ref().child(imagePath1);
                  final imagePath2 = 'images' + imagePath + "/_image2";
                  final ref2 = FirebaseStorage.instance.ref().child(imagePath2);
                  final imagePath3 = 'images' + imagePath + "/_image3";
                  final ref3 = FirebaseStorage.instance.ref().child(imagePath3);
                  final imagePath4 = 'images' + imagePath + "/_image4";
                  final ref4 = FirebaseStorage.instance.ref().child(imagePath4);
                  var url1 = await ref1.getDownloadURL();
                  var url2 = await ref2.getDownloadURL();
                  var url3 = await ref3.getDownloadURL();
                  var url4 = await ref4.getDownloadURL();
                  Image image1 = Image.network(url1,
                      width: 75, height: 75, fit: BoxFit.fill);
                  Image image2 = Image.network(url2,
                      width: 75, height: 75, fit: BoxFit.fill);
                  Image image3 = Image.network(url3,
                      width: 75, height: 75, fit: BoxFit.fill);
                  Image image4 = Image.network(url4,
                      width: 75, height: 75, fit: BoxFit.fill);

                  Navigator.pushNamed(context, '/viewPostDetail',
                      arguments: ItemPostDetailModel(
                          arguments[index], url1, url2, url3, url4));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            arguments[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Text(
                            arguments[index].price,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            arguments[index].description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Hyper Garage Sale'),
    //   ),
    //   body: Center(
    //     child: FutureBuilder(
    //       future: ItemModel.readAll(), //callback to receive new passed in item
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData == false ||
    //             snapshot.data == null ||
    //             snapshot.data == '') {
    //           return const Text(
    //               'No items found. \nPlease clock on + button to add new item.');
    //         } // check if snapshot contains data
    //
    //         var _tempItemInfoList = snapshot.data as List<Info>;
    //         // print("Temporary Info List count => " + _tempItemInfoList.length.toString());
    //
    //         return ListView.builder(
    //           itemBuilder: (context, index) {
    //             return Card(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text(
    //                           _tempItemInfoList[index].name,
    //                           style: const TextStyle(
    //                               fontWeight: FontWeight.bold, fontSize: 24),
    //                         ),
    //                         Text(
    //                           _tempItemInfoList[index].price,
    //                           style: const TextStyle(
    //                               fontWeight: FontWeight.bold, fontSize: 14),
    //                         ),
    //                         Text(
    //                           _tempItemInfoList[index].description,
    //                           style: const TextStyle(
    //                               fontWeight: FontWeight.bold, fontSize: 14),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //           itemCount:
    //               _tempItemInfoList == null ? 0 : _tempItemInfoList.length,
    //         );
    //       }, // builder
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, '/postNewItem');
    //     },
    //     tooltip: 'Post New Item',
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}
