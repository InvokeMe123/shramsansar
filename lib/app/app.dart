import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/dashboard.dart';
import 'package:shramsansar/features/auth/presentation/controller/auth_controller.dart';

class ShramsansarApp extends ConsumerWidget {
  const ShramsansarApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(builder: (context, orientation, screentype) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: AppColorConst.PRAYMARY_TEXT_COLOR,
            foregroundColor: AppColorConst.PRAYMERY_COLOR,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            filled: true,
            fillColor: const Color(0xffF1F1F1),
          ),
        ),
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
