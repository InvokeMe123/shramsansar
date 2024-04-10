import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NationalIdCardButton extends StatelessWidget {
  const NationalIdCardButton({super.key});

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
          debugPrint(file!.path);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: const Text("National ID Card"),
      ),
    );
  }
}
