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
import 'package:shramsansar/features/all_jobs/presentation/views/all_jobs_list.dart';
import 'package:shramsansar/features/auth/presentation/views/change_password/change_password.dart';
import 'package:shramsansar/features/auth/presentation/views/login/loginScreen.dart';

import 'package:shramsansar/features/edit_profile/presentation/views/profile_edit_page.dart';

import 'package:shramsansar/features/latest_training/presentation/views/latest_training.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

import 'package:shramsansar/features/profile/presentation/views/profile_page.dart';
import 'package:shramsansar/features/trainings/presentation/views/training_page.dart';
import 'package:shramsansar/features/training_center/presentation/views/training_center.dart';
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
    final profile = ref.watch(profileControllerProvider);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    //child: Image.asset(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  profile.when(
                      data: (data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(data.email!),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(data.perDistrictName.toString() +
                                    ' ,' +
                                    data.perPradeshName.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(data.mobile ?? ''),
                              ],
                            ),
                          ],
                        );
                      },
                      error: (_, __) => Text('error'),
                      loading: () => const CircularProgressIndicator())
                ],
              ),
            ),
            Divider(),
            TextButton(
                onPressed: () {
                  normalNav(context, const ProfilePage());
                },
                child: Text(
                  'View Profile',
                  style: TextStyle(
                      color: AppColorConst.BUTTON_BLUE_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {
                  normalNav(context, const ProfileEditPage());
                },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: AppColorConst.BUTTON_BLUE_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {
                  normalNav(context, const ChangePassword());
                },
                child: Text(
                  'Change password',
                  style: TextStyle(
                      color: AppColorConst.BUTTON_BLUE_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {
                  normalNav(context, const AllJobs());
                },
                child: Text(
                  'View Jobs',
                  style: TextStyle(
                      color: AppColorConst.BUTTON_BLUE_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                )),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        width: 21.w,
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
                        width: 21.w,
                        decoration:
                            BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                        child: const Center(child: Text('Training'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Container(
                      height: 18.h,
                      width: 21.w,
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
                        width: 21.w,
                        decoration:
                            BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                        child: const Center(child: Text('Training\nCenters'))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Latest Training",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const Divider(color: Colors.black),
            const LatestTraining(),
            const SizedBox(
              height: 10,
            ),
            const Text('Latest Jobs',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const Divider(color: Colors.black),
            Expanded(
              child: latestJobs.when(
                  data: (data) {
                    return ListView.builder(
                        itemCount: data.data!.length,
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
                    child: Text('See All Jobs ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
