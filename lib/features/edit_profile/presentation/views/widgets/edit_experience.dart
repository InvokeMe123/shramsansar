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
import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class EditExperience extends ConsumerStatefulWidget {
  Experiences experienceModel;
  EditExperience({super.key, required this.experienceModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditExperienceState();
}

class _EditExperienceState extends ConsumerState<EditExperience> {
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
  String fileName = 'Choose File';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    position.text = widget.experienceModel.title!;
    organizationName.text = widget.experienceModel.organization!;
    address.text = widget.experienceModel.location!;
    referenceName.text = widget.experienceModel.referenceName!;
    referenceNum.text = widget.experienceModel.referenceContact!;
    startDate.text = widget.experienceModel.startDate!;
    endDate.text = widget.experienceModel.endDate!;
    isCurrentlyWorking = widget.experienceModel.isCurrentlyWorking!;
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
                    'Update Experience',
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
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Job Position';
                      }
                      return null;
                    },
                    controller: position,
                    decoration: const InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(7),
                        label: Text("Job Position *"),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5))),
                  ),
                  SizedBox(height: 1.2.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: organizationName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Org. Name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(7),
                            label: Text('Org. Name *'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Address';
                            }
                            return null;
                          },
                          controller: address,
                          decoration: const InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(7),
                            label: Text('Address *'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.2.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Start Date';
                            }
                            return null;
                          },
                          controller: startDate,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(7),
                            label: Text("Start Date *"),
                          ),
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
                  SizedBox(height: 1.2.h),
                  !isWorking
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .365,
                              child: TextFormField(
                                controller: endDate,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(7),
                                  label: Text("End Date"),
                                  isDense: true,
                                ),
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
                            ),
                            SizedBox(height: 1.2.h),
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Ref. Name';
                            }
                            return null;
                          },
                          controller: referenceName,
                          decoration: const InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(7),
                              label: Text('Ref. Name *'),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5))),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Ref. Number';
                            } else if (value.length != 10) {
                              return 'Should be 10 digit';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: referenceNum,
                          decoration: const InputDecoration(
                              isDense: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(7),
                              label: Text("Ref. Number *"),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: .5))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.2.h),
                  const Text('Experience Certification'),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        experience();
                      },
                      style: TextButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: fileName != "Choose File"
                            ? AppColorConst.PRAYMARY_TEXT_COLOR.withAlpha(195)
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: Text(fileName),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
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
                              "end_date":
                                  (isCurrentlyWorking == 1) ? '' : endDate.text,
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
                                .editExperienceC(
                                    widget.experienceModel.id!, formData)
                                .then((value) {
                              if (value) {
                                ref
                                    .read(profileControllerProvider.notifier)
                                    .getMyProfile()
                                    .then((value) {
                                  Navigator.pop(context);
                                  showCustomSnackBar(
                                      "Experience succesfully updated.",
                                      context,
                                      isError: false);
                                });
                              } else {
                                showCustomSnackBar(
                                    'Failed to add updated', context);
                              }
                            });
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        )),
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
