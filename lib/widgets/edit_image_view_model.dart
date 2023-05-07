import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_editor_app/models/text_info.dart';
import 'package:photo_editor_app/screens/edit_image_screen.dart';
import 'package:photo_editor_app/widgets/default_button.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/utils.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  int currentIndex = 0;

  //* Add  Text
  List<TextInfo> texts = [];

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected for Styling',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  //Change text color
  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  //Increase font size
  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  //Decrease the font size
  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  //Align
  textAlignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  textAlignCentert() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  textAlignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  //Bold text
  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  //remove text
  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
            text: textEditingController.text,
            left: 0,
            top: 0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            textAlign: TextAlign.left),
      );
      Navigator.of(context).pop();
    });
  }

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
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
            textColor: Colors.black,
            child: const Text('Back'),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            color: Colors.red,
            textColor: Colors.white,
            child: const Text('Add Text'),
          ),
        ],
      ),
    );
  }
}
