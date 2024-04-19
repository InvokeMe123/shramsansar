import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BoldFirstWord extends StatelessWidget {
  final String firstWord;
  final String lastWord;

  const BoldFirstWord({
    super.key,
    required this.firstWord,
    required this.lastWord,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstWord,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.5,
          fontSize: 16.sp,
        ),
        children: <TextSpan>[
          TextSpan(
            text: lastWord,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
