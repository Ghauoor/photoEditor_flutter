import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/edit_image_view_model.dart';
import '../widgets/image_text.dart';

class EditImageScreen extends StatefulWidget {
  final String selectedImage;
  const EditImageScreen({
    super.key,
    required this.selectedImage,
  });

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Stack(
          children: <Widget>[
            _selectedImage,
            for (int i = 0; i < texts.length; i++)
              Positioned(
                left: texts[i].left,
                top: texts[i].top,
                child: GestureDetector(
                  onLongPress: () => print('Long Press is Detected'),
                  onTap: () => print('Naruto'),
                  child: Draggable(
                    feedback: ImagesText(
                      textInfo: texts[i],
                    ),
                    child: ImagesText(
                      textInfo: texts[i],
                    ),
                    onDragEnd: (drag) {
                      final renderBox = context.findRenderObject() as RenderBox;

                      Offset off = renderBox.globalToLocal(drag.offset);
                      setState(
                        () {
                          texts[i].top = off.dy - 96;
                          texts[i].left = off.dx - 96;
                        },
                      );
                    },
                  ),
                ),
              ),
            creatorText.text.isNotEmpty
                ? Positioned(
                    left: 0,
                    bottom: 0,
                    child: Text(
                      creatorText.text,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.3)),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      )),
      floatingActionButton: _addNewTextFab,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(
            widget.selectedImage,
          ),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );

  Widget get _addNewTextFab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: 'Add New Text',
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
}
