import 'package:flutter/material.dart';
import 'package:photo_editor_app/screens/edit_image_screen.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  //*add new dialog
  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add New Text'),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: 'Type your Text here'),
        ),
        actions: <Widget>[
          
        ],
      ),

    );
  }
}
