import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shramsansar/commons/latest_job_card.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/all_jobs/presentation/controller/latest_job_controller.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/all_jobs.dart';
import 'package:shramsansar/features/auth/presentation/views/login/loginScreen.dart';

import 'package:shramsansar/features/edit_profile/presentation/views/profile_edit_page.dart';

import 'package:shramsansar/features/latest_training/presentation/views/latest_training.dart';
import 'package:shramsansar/features/profile/presentation/views/profile_edit_page.dart';

import 'package:shramsansar/features/profile/presentation/views/profile_page.dart';
import 'package:shramsansar/features/trainings/presentation/views/training_page.dart';
import 'package:shramsansar/training_center/presentation/views/training_center.dart';
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
    final latestJobs = ref.watch(latestJobControllerProvider);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Profile',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [CircleAvatar(), Text('')],
              ),
            ),
            Divider(),
            TextButton(
                onPressed: () {
                  normalNav(context, ProfilePage());
                },
                child: Text('View Profile')),
            TextButton(
                onPressed: () {
                  normalNav(context, ProfileEditPage());
                },
                child: Text('Edit Profile'))
          ],
        ),
      ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // normalNav(context, AllJobs());
                    normalNav(context, AllJobs());
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
                GestureDetector(
                  onTap: () {
                    normalNav(context, TrainingPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Container(
                        height: 18.h,
                        width: 22.w,
                        decoration:
                            BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                        child: const Center(child: Text('Training'))),
                  ),
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
                GestureDetector(
                  onTap: () => normalNav(context, const TrainingCenters()),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Container(
                        height: 18.h,
                        width: 22.w,
                        decoration:
                            BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                        child: const Center(child: Text('Training\nCenters'))),
                  ),
                ),
              ],
            ),
            const Text("Latest Training"),
            const LatestTraining(),
            const SizedBox(
              height: 10,
            ),
            const Text('Latest Jobs'),
            const Divider(color: Colors.black),
            Expanded(
              child: latestJobs.when(
                  data: (data) {
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return LatestJobCard(data: data.data![index]);
                        });
                  },
                  error: (_, __) {
                    return Text("he");
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator())),
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      normalNav(context, AllJobs());
                    },
                    child: Text('See All Jobs '))
              ],
            )
          ],
        ),
      ),
    );
  }
}
