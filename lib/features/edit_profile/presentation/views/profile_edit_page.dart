import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_req_model.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/about_me_controller/about_me_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/about_me_controller/about_you_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    var profile = ref.watch(profileControllerProvider);
    var aboutYou = ref.watch(aboutYouControllerProvider);
    ref.refresh(aboutMeUpdateControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
        title: const Center(
            child: Text(
          'Profile Edit Page',
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
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(color: Colors.grey.shade300),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 35.w),
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit))
                                ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    const Icon(Icons.mail_outline),
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
                                    const Icon(Icons.phone_outlined),
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'About Me',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                editAboutMe(
                                    context, data.aboutYourself!.description!);
                              },
                              child:
                                  const Icon(Icons.edit, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: aboutYou.when(
                              data: (data) {
                                return Text(data.aboutYou!
                                    .map((e) => e.aboutMe)
                                    .join(''));
                              },
                              error: (_, __) {},
                              loading: () =>
                                  const CircularProgressIndicator())),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Education',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                educationAdd(context);
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.educations!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data.educations![index].levels!.name
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.edit,
                                          color: Colors.black),
                                    )
                                  ],
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Experience',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          itemCount: data.experiences!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data.experiences![index].title.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.edit,
                                          color: Colors.black),
                                    )
                                  ],
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Training/Certifications',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child:
                                  const Icon(Icons.edit, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Languages',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child:
                                  const Icon(Icons.edit, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Social Media Accounts',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child:
                                  const Icon(Icons.edit, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.socialAccounts!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  data.socialAccounts![index].name.toString() +
                                      ':' +
                                      data.socialAccounts![index].url
                                          .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            );
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColorConst.BUTTON_BLUE_COLOR,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Characteristics',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child:
                                  const Icon(Icons.edit, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (_, __) {
                return const Text("he");
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }

  void educationAdd(BuildContext context) {
    //var education = ref
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration:
                      BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
                  child: Row(
                    children: [
                      Text(
                        'Add Education',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Level'),
                        Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text('Education Board'),
                        Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Program'),
                        Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text('Institute'),
                        Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        DatePickerDialog(
                          firstDate: DateTime.utc(2000),
                          lastDate: DateTime.utc(2100),
                          currentDate: DateTime.now(),
                        );
                      },
                      child: Column(
                        children: [
                          Text('Graduate Year'),
                          Container(
                              height: 40,
                              width: MediaQuery.sizeOf(context).width * 0.38,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Text(DateTime.now().toString()))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text('Institute'),
                        Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void editAboutMe(BuildContext context, String data) {
    var details = ref.watch(aboutMeUpdateControllerProvider.notifier);

    TextEditingController aboutMe = TextEditingController();
    aboutMe.text = data;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(15),
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              decoration: BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
              child: Row(
                children: [
                  const Text('Edit About Me'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: aboutMe,
                  maxLength: 250,
                  maxLines: 7,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
                    ),
                    onPressed: () {
                      String aboutMeUpdate = aboutMe.text;
                      AboutMeUpdateReqModel aboutMeUpdateReqModel =
                          AboutMeUpdateReqModel(about_me: aboutMeUpdate);
                      details.getAboutMe(aboutMeUpdateReqModel);

                      Navigator.of(context).pop();

                      ref.refresh(profileControllerProvider);
                      ref.refresh(aboutMeUpdateControllerProvider);

                      showCustomSnackBar('Successfully Updated', context,
                          isError: false);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          );
        });
  }
}
