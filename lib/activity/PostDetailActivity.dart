import 'package:flutter/material.dart';

import 'BrowsePostsActivity.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final postItem =
        ModalRoute.of(context)!.settings.arguments as ItemPostDetailModel;
    Image image1 =
        Image.network(postItem.url1, width: 75, height: 75, fit: BoxFit.fill);
    Image image2 =
        Image.network(postItem.url2, width: 75, height: 75, fit: BoxFit.fill);
    Image image3 =
        Image.network(postItem.url3, width: 75, height: 75, fit: BoxFit.fill);
    Image image4 =
        Image.network(postItem.url4, width: 75, height: 75, fit: BoxFit.fill);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Item Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(postItem.textModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Item Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(postItem.textModel.price,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Item Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(postItem.textModel.description,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/viewFullScreenImage',
                            arguments: postItem.url1);
                      },
                      child: image1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/viewFullScreenImage',
                            arguments: postItem.url2);
                      },
                      child: image2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/viewFullScreenImage',
                            arguments: postItem.url3);
                      },
                      child: image3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/viewFullScreenImage',
                            arguments: postItem.url4);
                      },
                      child: image4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class PostDetailPage extends StatelessWidget {
//   const PostDetailPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final postItem = ModalRoute.of(context)!.settings.arguments as ItemPostInfo;
//     final imagePath = postItem.path;
//
//     _loadImage(imagePath) async {
//       final imagePath1 = 'images' + imagePath + "/_image1";
//       final ref = FirebaseStorage.instance.ref().child(imagePath1);
//       // no need of the file extension, the name will do fine.
//       var url1 = await ref.getDownloadURL();
//       print(url1);
//     }
//
//     _loadImage(imagePath);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post Detail'),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text('Item Name',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(postItem.name,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18)),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text('Item Price',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(postItem.price,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18)),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text('Item Description',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(postItem.description,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18)),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
