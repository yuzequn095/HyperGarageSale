import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PostNewItemForm.dart';

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
