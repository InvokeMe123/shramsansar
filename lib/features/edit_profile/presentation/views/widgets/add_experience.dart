import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/experience_controller/experience_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class AddExperience extends ConsumerStatefulWidget {
  const AddExperience({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddExperienceState();
}

class _AddExperienceState extends ConsumerState<AddExperience> {
  bool isChecked = false;
  TextEditingController position = TextEditingController();
  TextEditingController organizationName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController referenceName = TextEditingController();
  TextEditingController referenceNum = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isWorking = true;
  int isCurrentlyWorking = 0;

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    return DateFormat('yyyy-MM-dd').format(date);
  }

  String filePath1 = '';
  String fileName = '';
  bool isSelected = false;
  void experience() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'jpg'],
    );
    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.single.path!;
      String filename = result.files.single.name;
      setState(() {
        filePath1 = filePath;
        fileName = filename;
        isSelected = true;
      });
    }
    //log(fileName);
    //log(filePath1);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        contentPadding: const EdgeInsets.all(0),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              width: MediaQuery.sizeOf(context).width,
              height: 30,
              decoration: BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
              child: Row(
                children: [
                  Text(
                    'Add Experience',
                    style: TextStyle(color: AppColorConst.PRAYMARY_TEXT_COLOR),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColorConst.BUTTON_BLUE_COLOR,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Job Position *'),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Job Position';
                      }
                      return null;
                    },
                    controller: position,
                    decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(7),
                        constraints: BoxConstraints.tight(
                            Size(MediaQuery.sizeOf(context).width, 40)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5))),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Organization Name *'),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: organizationName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Organization Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(7),
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.sizeOf(context).width * .365,
                                    40)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address *'),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Address';
                              }
                              return null;
                            },
                            controller: address,
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(7),
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.sizeOf(context).width * .365,
                                    40)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5))),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date *'),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Start Date';
                              }
                              return null;
                            },
                            controller: startDate,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(7),
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.sizeOf(context).width * .365,
                                    40)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5))),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime.now());
                              if (picked != null) {
                                setState(() {
                                  startDate.text = _formatDate(picked);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Checkbox(
                        value:
                            isWorking, // Set the value of the checkbox based on the isChecked variable
                        onChanged: (newValue) {
                          // When the checkbox is tapped, update the isChecked variable
                          setState(() {
                            isWorking = newValue!;
                          });
                        },
                      ),
                      const Text('Currently working')
                    ],
                  ),
                  !isWorking
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('End Date'),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: endDate,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(7),
                                  constraints: BoxConstraints.tight(Size(
                                      MediaQuery.sizeOf(context).width * .365,
                                      40)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5))),
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime.now());
                                if (picked != null) {
                                  setState(() {
                                    endDate.text = _formatDate(picked);
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Reference Name *'),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Reference Name';
                              }
                              return null;
                            },
                            controller: referenceName,
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(7),
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.sizeOf(context).width * .365,
                                    40)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Reference Number *'),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Reference Number';
                              } else if (value.length != 10) {
                                return 'Should be 10 digit';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: referenceNum,
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(7),
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.sizeOf(context).width * .365,
                                    40)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: .5))),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text('Experience Certification'),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 35,
                    width: MediaQuery.sizeOf(context).width * .5,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(10.w, 4.h),
                          fixedSize: Size(10.w, 4.h),
                          maximumSize: Size(10.w, 4.h),
                          backgroundColor: Colors.grey),
                      onPressed: () {
                        experience();
                      },
                      child: Text(
                        isSelected ? fileName : 'Choose File',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(20.w, 4.h),
                              fixedSize: Size(20.w, 4.h),
                              maximumSize: Size(20.w, 4.h),
                              backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (isWorking) {
                                isCurrentlyWorking = 1;
                              } else {
                                isCurrentlyWorking = 0;
                              }
                              log(isWorking.toString());
                              log(isCurrentlyWorking.toString());

                              var dataForm = {
                                "title": position.text,
                                "organization": organizationName.text,
                                "reference_name": referenceName.text,
                                "reference_contact": referenceNum.text,
                                "location": address.text,
                                "start_date": startDate.text,
                                "end_date": (isCurrentlyWorking == 1)
                                    ? ''
                                    : endDate.text,
                                "is_currently_working": isCurrentlyWorking,
                                
                              }; 
                              
                              if (filePath1.isNotEmpty) {
                                dataForm['file'] = MultipartFile.fromFileSync(
                                    filePath1,
                                    filename: fileName);
                              }

                              
                              final formData = FormData.fromMap(dataForm);

                              ref
                                  .read(experienceControllerProvider.notifier)
                                  .addExperience(formData)
                                  .then((value) {
                                if (value) {
                                  ref
                                      .read(profileControllerProvider.notifier)
                                      .getMyProfile()
                                      .then((value) {
                                    Navigator.pop(context);
                                    showCustomSnackBar(
                                        "Experience succesfully added.",
                                        context,
                                        isError: false);
                                  });
                                } else {
                                  showCustomSnackBar(
                                      'Failed to add experience', context);
                                }
                              });
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
