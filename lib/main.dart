import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shramsansar/app/app.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: ShramsansarApp()));
}
