import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/language_model/language_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/social_accounts_model.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/education_controller/education_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/experience_controller/experience_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/language_controller/language_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/social_accounts_controller/social_accounts_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/training_certification_controller/training_certification_controller.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/full_profile_edit_page.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/add_education.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/add_experience.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/add_social_media.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/add_training_certification.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/edit_education.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/edit_experience.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/editing_training_certification.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/language_related/add_language.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/language_related/edit_language.dart';
import 'package:shramsansar/features/edit_profile/presentation/views/widgets/language_related/stars_rating.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

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

  // List of education levels
  List<String> educationLevels = [];

  // for storing social accounts
  SocialAccountsModel socialAccountsModel = SocialAccountsModel.empty();

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileControllerProvider);

    // adding education levels
    ref.watch(educationControllerProvider).when(
        data: (data) {
          for (var model in data.data!) {
            educationLevels.add(model.name!);
          }
        },
        error: (_, __) {},
        loading: () {});

    // adding social accounts data
    ref.watch(socialAccountsControllerProvider).when(
        data: (data) {
          socialAccountsModel = data;
        },
        error: (_, __) {},
        loading: () {});

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profile Edit Page')),
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
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/cv.png")),
                                        shape: BoxShape.circle,
                                        color: Colors.blue),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        normalNav(
                                            context, FullProfileEditPage(myProfileModel));
                                      },
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        "${myProfileModel.perDistrictName}, ${myProfileModel.perMuniName}, ${myProfileModel.perWard}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal),
                                      ),
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
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AddEducation(
                                          profileModel: myProfileModel,
                                          educationLevel:
                                              educationLevels.toSet().toList());
                                    });
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
                                              .educations![index].levelName ??
                                          "",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(profileControllerProvider
                                                .notifier)
                                            .deleteEducation(
                                                profileModel: myProfileModel,
                                                id: myProfileModel
                                                    .educations![index].id!);
                                      },
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        log("Edit education");
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return EditEducation(
                                                  profileModel: myProfileModel,
                                                  educationModel: myProfileModel
                                                      .educations![index],
                                                  educationLevel:
                                                      educationLevels
                                                          .toSet()
                                                          .toList());
                                            });
                                      },
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
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const AddExperience();
                                    });
                              },
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
                                      onTap: () {
                                        ref
                                            .read(experienceControllerProvider
                                                .notifier)
                                            .deleteExperienceC(myProfileModel
                                                .experiences![index].id!)
                                            .then((value) {
                                          if (value) {
                                            ref
                                                .read(profileControllerProvider
                                                    .notifier)
                                                .getMyProfile();
                                            showCustomSnackBar(
                                                "Sucessfully Delete", context,
                                                isError: false);
                                          } else {
                                            showCustomSnackBar(
                                                "Failed to delete experience",
                                                context);
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return EditExperience(
                                                experienceModel: myProfileModel
                                                    .experiences![index],
                                              );
                                            });
                                      },
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
                                const SizedBox(
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
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const AddTrainingCertificate();
                                    });
                              },
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
                          shrinkWrap: true,
                          itemCount: myProfileModel.trainings!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      myProfileModel.trainings![index].title
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(
                                                trainingCertificationControllerProvider
                                                    .notifier)
                                            .deleteExperienceC(myProfileModel
                                                .trainings![index].id!)
                                            .then((value) {
                                          if (value) {
                                            ref
                                                .watch(profileControllerProvider
                                                    .notifier)
                                                .getMyProfile()
                                                .then((value) {
                                              showCustomSnackBar(
                                                  "Successsfully Deleted",
                                                  context,
                                                  isError: false);
                                            });
                                          } else {
                                            showCustomSnackBar(
                                                "Failed to Delete", context,
                                                isError: true);
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return EditTrainingCertificate(
                                                  trainings: myProfileModel
                                                      .trainings![index]);
                                            });
                                      },
                                      child: const Icon(Icons.edit,
                                          color: Colors.black),
                                    )
                                  ],
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
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => const AddLanguage());
                              },
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
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: myProfileModel.languages!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      myProfileModel
                                          .languages![index].languageName
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(languageControllerProvider
                                                .notifier)
                                            .deleteLanguage(myProfileModel
                                                .languages![index].id!)
                                            .then((value) {
                                          if (value) {
                                            ref
                                                .read(profileControllerProvider
                                                    .notifier)
                                                .getMyProfile()
                                                .then((value) {
                                              showCustomSnackBar(
                                                  'Successfully Deleted',
                                                  context,
                                                  isError: false);
                                            });
                                          } else {
                                            showCustomSnackBar(
                                                'Failed to delete', context,
                                                isError: true);
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.delete_outline,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => EditLanguage(
                                              languageModel:
                                                  LanguageModel.fromMap(
                                                      myProfileModel
                                                          .languages![index]
                                                          .toJson())),
                                        );
                                      },
                                      child: const Icon(Icons.edit,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Listening",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    StarRating(
                                        count: int.parse(myProfileModel
                                            .languages![index]
                                            .languageRatingListening!)),
                                    // Text(
                                    //   myProfileModel.languages![index]
                                    //       .languageRatingListening
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 14.sp,
                                    //       fontWeight: FontWeight.normal),
                                    // ),

                                    Text(
                                      "Reading",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    StarRating(
                                        count: int.parse(myProfileModel
                                            .languages![index]
                                            .languageRatingReading!)),
                                    // Text(
                                    //   myProfileModel.languages![index]
                                    //       .languageRatingReading
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 14.sp,
                                    //       fontWeight: FontWeight.normal),
                                    // ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Speaking",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    StarRating(
                                        count: int.parse(myProfileModel
                                            .languages![index]
                                            .languageRatingSpeaking!)),
                                    // Text(
                                    //   myProfileModel.languages![index]
                                    //       .languageRatingSpeaking
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 14.sp,
                                    //       fontWeight: FontWeight.normal),
                                    // ),

                                    Text(
                                      "Writing",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    StarRating(
                                        count: int.parse(myProfileModel
                                            .languages![index]
                                            .languageRatingWriting!)),
                                    // Text(
                                    //   myProfileModel.languages![index]
                                    //       .languageRatingWriting
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 14.sp,
                                    //       fontWeight: FontWeight.normal),
                                    // ),
                                  ],
                                ),
                                const SizedBox(
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
                              'Social Media Accounts',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AddSocialMedia(
                                          socialAccountsModel:
                                              socialAccountsModel,
                                        ));
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
                          itemCount: myProfileModel.socialAccounts!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${myProfileModel.socialAccounts![index].name}:${myProfileModel.socialAccounts![index].url}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      ref
                                          .read(socialAccountsControllerProvider
                                              .notifier)
                                          .deleteSocialAccount(myProfileModel
                                              .socialAccounts![index].id!)
                                          .then((value) {
                                        if (value) {
                                          ref
                                              .read(profileControllerProvider
                                                  .notifier)
                                              .getMyProfile()
                                              .then((value) {
                                            showCustomSnackBar(
                                                'Successfully Deleted', context,
                                                isError: false);
                                          });
                                        } else {
                                          showCustomSnackBar(
                                              'Failed to delete', context,
                                              isError: true);
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.delete_outline))
                              ],
                            );
                          }),
                      const SizedBox(
                        height: 10,
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

  void editAboutMe(BuildContext context, String data, MyProfileModel model) {
    TextEditingController aboutMe = TextEditingController();
    aboutMe.text = data;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(15),
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              height: 30,
              decoration: BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Edit About Me',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide:
                              BorderSide(color: Colors.black, width: .5))),
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
