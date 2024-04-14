import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shramsansar/app/app.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shramsansar/features/edit_profile/presentation/views/profile_edit_page.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();

  runApp(provider.MultiProvider(providers: [
    provider.ChangeNotifierProvider(create: (context) => DateChange())
  ], child: const ProviderScope(child: ShramsansarApp())));
}
