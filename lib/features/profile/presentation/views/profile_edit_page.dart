import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    var profile = ref.watch(profileControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
        title: Center(
            child: Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profile.when(
              data: (data) {
                log(data.id.toString());
                log(data.educations!.length.toString());

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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                        ),
                      ),
                      Center(
                        child: Text(
                          data.name!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(6),
                                shape: RoundedRectangleBorder(),
                                backgroundColor:
                                    AppColorConst.BUTTON_BLUE_COLOR),
                            onPressed: () {},
                            child: Text(
                              'Generate CV',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Column(
                                children: [
                                  Text(
                                    data.locations!
                                        .map((e) => e.districtName)
                                        .join('')
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    data.locations!
                                        .map((e) => e.pradeshName)
                                        .join('')
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.mail_outline),
                              Text(
                                data.email!,
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
                                data.mobile!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
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
                          'About Me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(child: Text(data.aboutYourself!.description!)),
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
                          'Education',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.educations!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.educations![index].levels!.name
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.educations![index].graduationYear
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
                                    text: data.educations![index].program
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
                                    text: data.educations![index].board
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
                                    text: data.educations![index].institute
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
                          itemCount: data.experiences!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.experiences![index].title.toString(),
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
                                    text: data.experiences![index].startDate
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
                                    text: data.experiences![index].endDate
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
                                    text: data.experiences![index].organization
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
                          itemCount: data.trainings!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.trainings![index].title.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.trainings![index].year.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  data.trainings![index].provider.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  data.trainings![index].details.toString(),
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
