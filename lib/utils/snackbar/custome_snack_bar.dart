  import 'package:flutter/material.dart';

  import 'package:shramsansar/utils/responsive_helper/responsive_helper.dart';

  void showCustomSnackBar(String message, BuildContext context,
      {bool isError = true}) {
    final width = MediaQuery.of(context).size.width;
    ResponsiveHelper.isDesktop(context)
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              message,
            ),
            margin: ResponsiveHelper.isDesktop(context)
                ? EdgeInsets.only(right: width * 0.75, bottom: 25, left: 25)
                : const EdgeInsets.only(bottom: 25),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            duration: Duration(
                milliseconds: ResponsiveHelper.isDesktop(context) ? 1000 : 600),
            backgroundColor: isError ? Colors.red : Colors.green))
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: isError ? Colors.red : Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            content: Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            duration: const Duration(seconds: 4),
          ));
  }
