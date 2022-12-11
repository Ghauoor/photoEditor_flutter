import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_app/screens/edit_image_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.add_a_photo_outlined, size: 50),
          onPressed: () {
            _getFromGallery(context);
          },
        ),
      ),
    );
  }

//* Get Image from Gallery
  _getFromGallery(BuildContext cxt) async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      Navigator.of(cxt).push(
        MaterialPageRoute(
          builder: ((context) => EditImageScreen(selectedImage: file.path)),
        ),
      );
    }
  }
}
