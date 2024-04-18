import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var profile = ref.watch(profileControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Profile Page',
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profile.when(
              data: (myProfileModel) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                        ),
                      ),
                      Center(
                        child: Text(
                          myProfileModel.name!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(6),
                                shape: const RoundedRectangleBorder(),
                                backgroundColor:
                                    AppColorConst.BUTTON_BLUE_COLOR),
                            onPressed: () {},
                            child: const Text(
                              'Generate CV',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              Text(
                                "${myProfileModel.perDistrictId}, ${myProfileModel.perMuniName}, ${myProfileModel.perWard}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.mail_outline),
                              Text(
                                myProfileModel.email!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone_outlined),
                              Text(
                                myProfileModel.mobile!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: const Text(
                          'About Me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          child: Text(
                              myProfileModel.aboutYourself?.description ??
                                  "No description provided")),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Text(
                          'Education',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: myProfileModel.educations?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myProfileModel.educations![index].levels!.name
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  myProfileModel
                                      .educations![index].graduationYear
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Program: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: myProfileModel
                                        .educations![index].program
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Board: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: myProfileModel
                                        .educations![index].board
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Institute: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: myProfileModel
                                        .educations![index].institute
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Text(
                          'Experience',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          itemCount: myProfileModel.experiences!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myProfileModel.experiences![index].title
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'From: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: myProfileModel
                                        .experiences![index].startDate
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'To: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: myProfileModel
                                        .experiences![index].endDate
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Organization: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: myProfileModel
                                        .experiences![index].organization
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  )
                                ])),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Text(
                          'Training/Certifications',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: myProfileModel.trainings!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myProfileModel.trainings![index].title
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  myProfileModel.trainings![index].year
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  myProfileModel.trainings![index].provider
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  myProfileModel.trainings![index].details
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                );
              },
              error: (_, __) {
                return Text("he");
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
