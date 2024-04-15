import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_req_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/about_me_controller/about_me_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/about_me_controller/about_you_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/education_controller/educationAddController.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/education_controller/education_controller.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/features/trainings/provider/filtered_provider.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';
import 'package:provider/provider.dart' as providers;
import 'package:intl/intl.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  DateTime selectedDate = DateTime.now();

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : 'Select Date';
  }

  MyProfileModel myProfileModel = MyProfileModel();

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileControllerProvider);

    var aboutYou = ref.watch(aboutYouControllerProvider);
    var education = ref.watch(educationAddControllerProvider.notifier);

    // ref.refresh(aboutMeUpdateControllerProvider);
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
            profileProvider.when(
              data: (myProfileModel) {
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
                                myProfileModel.name!,
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
                                          myProfileModel.locations!
                                              .map((e) => e.districtName)
                                              .join('')
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          myProfileModel.locations!
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
                                    const Icon(Icons.phone_outlined),
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
                                    context,
                                    myProfileModel.aboutYourself?.description ??
                                        "",
                                    myProfileModel);
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
                      Text(myProfileModel.aboutYourself?.description ?? ""),
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
                          itemCount: myProfileModel.educations!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      myProfileModel
                                          .educations![index].levels!.name
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        education.deleteEducationn(
                                            myProfileModel
                                                .educations![index].id!);
                                        //profile1.getMyProfile();
                                      },
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
                          itemCount: myProfileModel.experiences!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      myProfileModel.experiences![index].title
                                          .toString(),
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
                          itemCount: myProfileModel.socialAccounts!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  myProfileModel.socialAccounts![index].name
                                          .toString() +
                                      ':' +
                                      myProfileModel.socialAccounts![index].url
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
    var education = ref.watch(educationControllerProvider);
    var educationAdd = ref.watch(educationAddControllerProvider.notifier);
    int level_id = 0;
    List<String> educationName = [];
    TextEditingController program = TextEditingController();
    TextEditingController educationBoard = TextEditingController();
    TextEditingController institute = TextEditingController();
    TextEditingController obtainedMarks = TextEditingController();
    var profile = ref.watch(profileControllerProvider.notifier);
    String ed = 'Education';
    String? educ;
    showDialog(
        context: context,
        builder: (context) {
          return providers.Consumer<DateChange>(
            builder: (context, dateChange, _) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      width: MediaQuery.sizeOf(context).width,
                      decoration:
                          BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
                      child: Row(
                        children: [
                          const Text(
                            'Add Education',
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child:
                                  const Icon(Icons.close, color: Colors.white))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Level'),
                            Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: education.when(
                                  data: (data) {
                                    for (var model in data.data!) {
                                      educationName.add(model.name!);
                                    }
                                    educationName =
                                        educationName.toSet().toList();
                                    return DropdownButton<String>(
                                      hint: const Text('Education'),
                                      value: educ ??
                                          (educationName.isEmpty
                                              ? null
                                              : educationName[0]),
                                      items: educationName.map((eduList) {
                                        return DropdownMenuItem<String>(
                                          value: eduList,
                                          child: Text(
                                            eduList,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          educ = newValue;
                                          level_id =
                                              educationName.indexOf(educ!) + 1;
                                        });
                                      },
                                    );
                                  },
                                  error: (_, __) {
                                    return Text('error');
                                  },
                                  loading: () => Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.28,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        child: CircularProgressIndicator(),
                                      )),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Education Board'),
                            Container(
                              height: 40,
                              width: MediaQuery.sizeOf(context).width * 0.38,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: educationBoard,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Program'),
                            Container(
                              height: 40,
                              width: MediaQuery.sizeOf(context).width * 0.38,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: program,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Institute'),
                            Container(
                              height: 40,
                              width: MediaQuery.sizeOf(context).width * 0.38,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: institute,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            if (picked != null) {
                              dateChange.changeDate(picked);
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Graduate Year'),
                              Container(
                                  height: 40,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.38,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                      '${_formatDate(dateChange.changedDate)}')),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Text('Obtained Marks'),
                            Container(
                              height: 40,
                              width: MediaQuery.sizeOf(context).width * 0.38,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: obtainedMarks,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              if (program.text.isEmpty ||
                                  educationBoard.text.isEmpty ||
                                  institute.text.isEmpty ||
                                  '${_formatDate(dateChange.changedDate)}'
                                      .isEmpty) {
                                return showCustomSnackBar(
                                    'Fields Cant be empty', context);
                              }
                              EducationReqModel educationReqModel =
                                  EducationReqModel(
                                      level_id: level_id.toString(),
                                      program: program.text,
                                      board: educationBoard.text,
                                      institute: institute.text,
                                      graduation_year:
                                          '${_formatDate(dateChange.changedDate)}',
                                      marks_secured: obtainedMarks.text);
                              educationAdd.addEducation(educationReqModel);
                              profile.getMyProfile();
                            },
                            child: Text('Save'))
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void editAboutMe(BuildContext context, String data, MyProfileModel model) {
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

                      ref
                          .watch(profileControllerProvider.notifier)
                          .updateAboutMe(
                              model: model, data: {"about_me": aboutMeUpdate});

                      Navigator.of(context).pop();

                      // ref.refresh(profileControllerProvider);
                      // ref.refresh(aboutMeUpdateControllerProvider);

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

class DateChange extends ChangeNotifier {
  DateTime changedDate = DateTime.now();

  void changeDate(DateTime newDate) {
    changedDate = newDate;
    notifyListeners();
  }
}
