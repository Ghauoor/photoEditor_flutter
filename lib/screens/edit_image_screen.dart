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
      appBar: _appBar,
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
                        final renderBox =
                            context.findRenderObject() as RenderBox;

                        Offset off = renderBox.globalToLocal(drag.offset);
                        setState(
                          () {
                            //Get these Values trail and Run
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
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
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
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

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Save Image',
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Increase font size',
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Decrease font size',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_align_left,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Align left',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_align_center,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Align Center',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_align_right,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Align Right',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Bold',
              ),
              IconButton(
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Italic',
              ),
              IconButton(
                icon: const Icon(
                  Icons.space_bar,
                  color: Colors.black,
                ),
                onPressed: () {},
                tooltip: 'Add New Line',
              ),
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Yellow',
                child: GestureDetector(
                    onTap: () => {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.yellow,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Green',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Orange',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.orange,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Pink',
                child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.pink,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
}
