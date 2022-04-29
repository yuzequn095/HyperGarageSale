import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/ItemModel.dart';

/*
 * Form to create new Item Model
 * Will be pushed to display activity
 */
class PostNewItemForm extends StatefulWidget {
  // const PostNewItemForm({Key? key}) : super(key: key);

  // modified for FireBase
  // const PostNewItemForm({required this.addItemInfo});
  const PostNewItemForm({required this.addItemInfo});
  final FutureOr<void> Function(
      String name, String price, String description, String path) addItemInfo;

  @override
  State<PostNewItemForm> createState() => _PostNewItemFormState();
}

class _PostNewItemFormState extends State<PostNewItemForm> {
  final _formKey = GlobalKey<FormState>();

  String path = "";

  // form controllers
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // image files and list
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  File? imageFile4;

  // array for each image taken
  var imageChoose = [false, false, false, false];

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _imageViewWidget(0),
                  ),
                  Expanded(
                    child: _imageViewWidget(1),
                  ),
                  Expanded(
                    child: _imageViewWidget(2),
                  ),
                  Expanded(
                    child: _imageViewWidget(3),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          path = imageFile1 == null ? "" : imageFile1!.path;
                          // store item info in Firebase
                          await widget.addItemInfo(
                              nameController.text,
                              priceController.text,
                              descriptionController.text,
                              path);

                          const postSuccessfullySnackBar = SnackBar(
                            content: Text('Your item posted! 0v0'),
                          );

                          _addNewItemInfoEntry(); // display item items in browse page

                          //clear controller
                          nameController.clear();
                          priceController.clear();
                          priceController.clear();

                          // locate where the SnackBar pop up
                          ScaffoldMessenger.of(context)
                              .showSnackBar(postSuccessfullySnackBar);

                          uploadImage(); // upload images to Firebase
                        }
                      },
                      child: const Text('Post Item'))),
            ),
          ],
        ),
      ),
    );
  }

  // push the form text into ItemDisplayPage
  void _addNewItemInfoEntry() {
    ItemModel.add(
        nameController.text, priceController.text, descriptionController.text);

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  // set image to specific imageFile
  _setImageFile(var id, XFile picture) {
    switch (id) {
      case 0:
        imageFile1 = File(picture.path);
        break;

      case 1:
        imageFile2 = File(picture.path);
        break;

      case 2:
        imageFile3 = File(picture.path);
        break;

      case 3:
        imageFile4 = File(picture.path);
        break;
    }
  }

  // get image to specific imageFile
  _getImageFile(var id) {
    switch (id) {
      case 0:
        return Image.file(imageFile1!, width: 250, height: 200);

      case 1:
        return Image.file(imageFile2!, width: 250, height: 200);

      case 2:
        return Image.file(imageFile3!, width: 250, height: 200);

      case 3:
        return Image.file(imageFile4!, width: 250, height: 200);
    }
  }

  // pick image from gallery and set image
  _openGallery(BuildContext context, var id) async {
    final XFile? picture =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _setImageFile(id, picture!);
    });
    imageChoose[id] = true;

    Navigator.of(context).pop();
  }

  // pick image from camera and set camera
  _openCamera(BuildContext context, var id) async {
    final XFile? picture =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _setImageFile(id, picture!);
    });
    imageChoose[id] = true;

    Navigator.of(context).pop();
  }

  // pop up a dialog to allow user choose source of image
  Future<void> _chooseImageFromSource(BuildContext context, var id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Make a choice"),
            ),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: const Text("Gallary"),
                    onTap: () {
                      _openGallery(context, id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _openCamera(context, id);
                    },
                  ),
                ),
              ],
            )),
          );
        });
  }

  // widget to display the images choose
  Widget _imageViewWidget(var id) {
    if (imageChoose[id] == false) {
      return TextButton(
        child: const Icon(Icons.add_a_photo, size: 50),
        onPressed: () {
          _chooseImageFromSource(context, id);
        },
      );
    } else {
      return _getImageFile(id);
    }
  }

  // upload images to specific folder in Firebase
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    String imageFolder = path;
    print(imageFolder);

    //Upload to Firebase
    await _firebaseStorage
        .ref()
        .child('images/$imageFolder/${nameController.text}_image1')
        .putFile(imageFile1!);

    await _firebaseStorage
        .ref()
        .child('images/$imageFolder/${nameController.text}_image2')
        .putFile(imageFile2!);

    await _firebaseStorage
        .ref()
        .child('images/$imageFolder/${nameController.text}_image3')
        .putFile(imageFile3!);

    await _firebaseStorage
        .ref()
        .child('images/$imageFolder/${nameController.text}_image4')
        .putFile(imageFile4!);
  }
}
