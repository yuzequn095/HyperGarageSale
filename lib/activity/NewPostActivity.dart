import 'package:flutter/material.dart';

import 'NewPostActivityForm.dart';

/*
 * This activity should be used to allow user to post new item.
 * It contains one form to save and pass data.
 */
class PostNewItemPage extends StatefulWidget {
  const PostNewItemPage({Key? key}) : super(key: key);

  @override
  State<PostNewItemPage> createState() => _PostNewItemPageState();
}

class _PostNewItemPageState extends State<PostNewItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post New Item'),
      ),
      body: const PostNewItemForm(),
    );
  }
}
