import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/commons/latest_job_card.dart';
import 'package:shramsansar/commons/training_card.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/aboutUs.dart';
import 'package:shramsansar/features/all_jobs/presentation/controller/latest_job_controller.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/all_jobs.dart';
import 'package:shramsansar/features/auth/presentation/views/change_password/change_password.dart';
import 'package:shramsansar/features/auth/presentation/views/login/loginScreen.dart';

import 'package:shramsansar/features/edit_profile/presentation/views/profile_edit_page.dart';
import 'package:shramsansar/features/latest_training/presentation/controller/latest_training_controller.dart';

import 'package:shramsansar/features/news_and_notices/presentation/views/news_notice.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

import 'package:shramsansar/features/profile/presentation/views/profile_page.dart';
import 'package:shramsansar/features/trainings/presentation/views/training_page.dart';
import 'package:shramsansar/features/training_center/presentation/views/training_center.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/shimmer/shimmer.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

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

  logout() async {
    await ApiClient(DbClient()).request(path: ApiConst.LOG_OUT_URI);
    await DbClient().removeData(dbkey: 'token').then(
      (value) {
        pushReplacement(context, const LoginScreen());
      },
    ).then((value) {
      showCustomSnackBar('Logged Out Successfully', context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final latestJobs = ref.watch(latestJobControllerProvider);
    final latestTraining = ref.watch(latestTrainingControllerProvider);
    final profile = ref.watch(profileControllerProvider);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            isLoggedIn
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/app_logo.png',
                          width: 80,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Shramsansar',
                            style: TextStyle(
                                letterSpacing: 0.5,
                                color: AppColorConst.BUTTON_BLUE_COLOR,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  isLoggedIn
                      ? CircleAvatar(
                          backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
                          backgroundImage: AssetImage("assets/images/cv.png"),
                          radius: 40,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 20,
                  ),
                  profile.when(
                      data: (data) {
                        if (data.email == null) {
                          return const SizedBox();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .4,
                              child: Text(
                                data.name!,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(data.email!),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    '${data.perDistrictName} ,${data.perPradeshName}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
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
                      error: (_, __) => const Text('error'),
                      loading: () {
                        if (isLoggedIn) {
                          return const CircularProgressIndicator();
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
            isLoggedIn ? const Divider() : Container(),
            isLoggedIn
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0.5),
                                color: Colors.black.withOpacity(0.4))
                          ]),
                      child: TextButton(
                          onPressed: () {
                            normalNav(context, const ProfilePage());
                          },
                          child: Text(
                            'View Profile',
                            style: TextStyle(
                                color: AppColorConst.WHAIT,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                : const SizedBox(),
            isLoggedIn
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0.5),
                                color: Colors.black.withOpacity(0.4))
                          ]),
                      child: TextButton(
                          onPressed: () {
                            normalNav(context, const ProfileEditPage());
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: AppColorConst.WHAIT,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                : const SizedBox(),
            isLoggedIn
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0.5),
                                color: Colors.black.withOpacity(0.4))
                          ]),
                      child: TextButton(
                          onPressed: () {
                            normalNav(context, const ChangePassword());
                          },
                          child: Text(
                            'Change password',
                            style: TextStyle(
                                color: AppColorConst.WHAIT,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    color: AppColorConst.BUTTON_BLUE_COLOR,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0.5),
                          color: Colors.black.withOpacity(0.4))
                    ]),
                child: TextButton(
                    onPressed: () {
                      normalNav(context, const AllJobs());
                    },
                    child: Text(
                      'Jobs',
                      style: TextStyle(
                          color: AppColorConst.WHAIT,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    color: AppColorConst.BUTTON_BLUE_COLOR,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0.5),
                          color: Colors.black.withOpacity(0.4))
                    ]),
                child: TextButton(
                    onPressed: () {
                      normalNav(context, const TrainingPage());
                    },
                    child: Text(
                      'Training',
                      style: TextStyle(
                          color: AppColorConst.WHAIT,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    color: AppColorConst.BUTTON_BLUE_COLOR,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0.5),
                          color: Colors.black.withOpacity(0.4))
                    ]),
                child: TextButton(
                    onPressed: () {
                      normalNav(context, const TrainingCenters());
                    },
                    child: Text(
                      'Training Centers',
                      style: TextStyle(
                          color: AppColorConst.WHAIT,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    color: AppColorConst.BUTTON_BLUE_COLOR,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0.5),
                          color: Colors.black.withOpacity(0.4))
                    ]),
                child: TextButton(
                    onPressed: () {
                      normalNav(context, const NewsNotice());
                    },
                    child: Text(
                      'News and Notices',
                      style: TextStyle(
                          color: AppColorConst.WHAIT,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    color: AppColorConst.BUTTON_BLUE_COLOR,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0.5),
                          color: Colors.black.withOpacity(0.4))
                    ]),
                child: TextButton(
                    onPressed: () {
                      normalNav(context, const AboutUs());
                    },
                    child: Text(
                      'About Us',
                      style: TextStyle(
                          color: AppColorConst.WHAIT,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
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
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  // normalNav(context, AllJobs());
                  normalNav(context, const AllJobs());
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
                  normalNav(context, const TrainingPage());
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
                child: GestureDetector(
                  onTap: () {
                    normalNav(context, const NewsNotice());
                  },
                  child: Container(
                      height: 18.h,
                      width: 22.w,
                      decoration:
                          BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                      child: const Center(child: Text('Notice and\nNews'))),
                ),
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(children: [
              const Text('Latest Jobs',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const Divider(color: Colors.black),
              latestJobs.when(data: (data) {
                if (data.data!.isEmpty) {
                  return const Text('No data found');
                }
                return Column(
                  children: [
                    for (int a = 0; a < 10; a++)
                      LatestJobCard(data: data.data![a]),
                  ],
                );
              }, error: (_, __) {
                return const Text('error');
              }, loading: () {
                return const ShimmerSkeleton(
                  count: 3,
                );
              }),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        normalNav(context, const AllJobs());
                      },
                      child: const Text('See All Jobs ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)))
                ],
              ),
              const Text("Latest Training",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const Divider(color: Colors.black),
              latestTraining.when(data: (data) {
                if (data.data!.isEmpty) {
                  return const Text('No training data found');
                }

                return Column(
                  children: [
                    for (int a = 0; a < 10; a++)
                      TrainingCard(model: data.data![a]),
                  ],
                );
              }, error: (_, __) {
                return const Text('error');
              }, loading: () {
                return const ShimmerSkeleton(
                  count: 3,
                );
              }),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
