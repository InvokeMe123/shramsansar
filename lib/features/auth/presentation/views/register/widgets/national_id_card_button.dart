import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shramsansar/const/app_color_const.dart';

class NationalIdCardButton extends StatefulWidget {
  final ValueChanged<String> imagePath;
  const NationalIdCardButton({super.key, required this.imagePath});

  @override
  State<NationalIdCardButton> createState() => _NationalIdCardButtonState();
}

class _NationalIdCardButtonState extends State<NationalIdCardButton> {
  String text = "National ID Card";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: TextButton(
        onPressed: () async {
          log("National ID Card clicked");
          final ImagePicker picker = ImagePicker();
          final file = await picker.pickImage(source: ImageSource.gallery);
          debugPrint(file?.path ?? '');

          if (file?.path != null) {
            widget.imagePath(file!.path);
            setState(() {
              text = file.path.split('/').last;
            });
          }
        },
        style: TextButton.styleFrom(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: text != "National ID Card"
              ? AppColorConst.PRAYMARY_TEXT_COLOR.withAlpha(195)
              : Colors.grey,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: Text(text),
      ),
    );
  }
}
