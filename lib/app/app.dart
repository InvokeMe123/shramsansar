import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/dashboard.dart';
import 'package:shramsansar/features/auth/presentation/controller/auth_controller.dart';
import 'package:shramsansar/features/auth/presentation/views/login/loginScreen.dart';

class ShramsansarApp extends ConsumerWidget {
  const ShramsansarApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(builder: (context, orientation, screentype) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: ref.watch(authControllerProvider).when(
            loggedIn: (data) {
              return const Dashboard();
            },
            loading: () => const CircularProgressIndicator(),
            loggedOut: () => const Dashboard()),
      );
    });
  }
}
