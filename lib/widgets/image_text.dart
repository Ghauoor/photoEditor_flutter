import 'package:flutter/material.dart';
import 'package:photo_editor_app/models/text_info.dart';

class ImagesText extends StatelessWidget {
  final TextInfo textInfo;

  const ImagesText({
    super.key,
    required this.textInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
        color: textInfo.color,
      ),
    );
  }
}
