import 'package:flutter/material.dart';

import '../model/ItemModel.dart';

/*
 * Form to create new Item Model
 * Will be pushed to display page
 */
class PostNewItemForm extends StatefulWidget {
  const PostNewItemForm({Key? key}) : super(key: key);

  @override
  State<PostNewItemForm> createState() => _PostNewItemFormState();
}

class _PostNewItemFormState extends State<PostNewItemForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // push the form text into ItemDisplayPage
  void _addNewItemInfoEntry() {
    ItemModel.add(
        nameController.text, priceController.text, descriptionController.text);

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('Name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the name of item';
                  }
                  return null;
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('Price',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the price of item';
                    }
                    return null;
                  }),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('Description',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the description of item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ElevatedButton(
                      onPressed: _addNewItemInfoEntry,
                      child: const Text('Post Item'))),
            )
          ],
        ),
      ),
    );
  }
}
