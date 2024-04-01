import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/all_jobs.dart';
import 'package:shramsansar/features/auth/presentation/views/login/loginScreen.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInState();
  }

  Future<void> checkLoggedInState() async {
    String result = await DbClient().getData(dbKey: 'token');
    log(result);
    if (result.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  logout() {
    DbClient().removeData(dbkey: 'token');
    normalNav(context, const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
        title: const Text(
          'Shramsansar',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          isLoggedIn
              ? TextButton(
                  onPressed: () {
                    logout();
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ))
              : TextButton(
                  onPressed: () {
                    normalNav(context, const LoginScreen());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ))
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                   // normalNav(context, AllJobs());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                        height: 18.h,
                        width: 22.w,
                        decoration:
                            BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                        child: const Center(child: Text('Jobs'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Container(
                      height: 18.h,
                      width: 22.w,
                      decoration:
                          BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                      child: const Center(child: Text('Training'))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Container(
                      height: 18.h,
                      width: 22.w,
                      decoration:
                          BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                      child: const Center(child: Text('Notice and\nNews'))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Container(
                      height: 18.h,
                      width: 22.w,
                      decoration:
                          BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                      child: const Center(child: Text('Training\nCenters'))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
