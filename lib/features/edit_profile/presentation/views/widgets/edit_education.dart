import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class EditEducation extends ConsumerStatefulWidget {
  final List<String> educationLevel;
  final MyProfileModel profileModel;

  /// selected fields are in this model
  final Educations educationModel;

  const EditEducation({
    super.key,
    required this.educationLevel,
    required this.profileModel,
    required this.educationModel,
  });

  @override
  ConsumerState<EditEducation> createState() => _AddEducationState();
}

class _AddEducationState extends ConsumerState<EditEducation> {
  int levelID = 0;
  TextEditingController program = TextEditingController();
  TextEditingController educationBoard = TextEditingController();
  TextEditingController institute = TextEditingController();
  TextEditingController obtainedMarks = TextEditingController();
  final graduateYearController = TextEditingController();

  String ed = 'Education';
  String? educ;

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    return DateFormat('yyyy-MM-dd').format(date);
  }

  // for validating the form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    levelID = widget.educationModel.levelId!;

    educ = widget.educationModel.levelName;
    program.text = widget.educationModel.program ?? "";
    educationBoard.text = widget.educationModel.board ?? "";
    institute.text = widget.educationModel.institute ?? "";
    obtainedMarks.text = widget.educationModel.marksSecured ?? "";
    graduateYearController.text = widget.educationModel.graduationYear ?? "";
  }

  @override
  Widget build(BuildContext context) {
    log("Selected fields data: ${widget.educationModel.toJson()}");

    return Form(
      key: _formKey,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Container(
          padding: const EdgeInsets.all(4),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
          child: Row(
            children: [
              const Text(
                'Edit Education',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, color: Colors.white))
            ],
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Level'),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(3),
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.sizeOf(context).width * .38, 50)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                        hint: const Text('Education'),
                        value: educ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select education level';
                          }
                          return null;
                        },
                        items: widget.educationLevel.map((eduList) {
                          return DropdownMenuItem<String>(
                            value: eduList,
                            child: Text(
                              eduList,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            educ = newValue;
                            levelID = widget.educationLevel.indexOf(educ!) + 1;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Education Board'),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(3),
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.sizeOf(context).width * .34, 50)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                        style: TextStyle(fontSize: 14),
                        controller: educationBoard,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter education board';
                          }
                          return null;
                        },
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
                      const Text('Program'),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(3),
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.sizeOf(context).width * .38, 50)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                        style: TextStyle(fontSize: 14),
                        controller: program,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter program';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Institute'),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(3),
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.sizeOf(context).width * .34, 50)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                        style: TextStyle(fontSize: 14),
                        controller: institute,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter institute';
                          }
                          return null;
                        },
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
                      const Text('Graduate Year'),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Select Date",
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(3),
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.sizeOf(context).width * .38, 50)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                        style: TextStyle(fontSize: 14),
                        textInputAction: TextInputAction.next,
                        controller: graduateYearController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select year';
                          }
                          return null;
                        },
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime.now());
                          if (picked != null) {
                            setState(() {
                              graduateYearController.text = _formatDate(picked);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Obtained Marks'),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(3),
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.sizeOf(context).width * .34, 50)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                        controller: obtainedMarks,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter obtained marks';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          EducationReqModel educationReqModel =
                              EducationReqModel(
                                  level_id: levelID.toString(),
                                  levelName: widget.educationLevel
                                      .elementAt(levelID - 1),
                                  program: program.text,
                                  board: educationBoard.text,
                                  institute: institute.text,
                                  graduation_year: graduateYearController.text,
                                  marks_secured: obtainedMarks.text);

                          ref
                              .read(profileControllerProvider.notifier)
                              .updateEducation(
                                  educationReqModel: educationReqModel,
                                  id: widget.educationModel.id!)
                              .then((value) {
                            if (value) {
                              ref
                                  .read(profileControllerProvider.notifier)
                                  .getMyProfile()
                                  .then((value) {
                                Navigator.pop(context);
                                showCustomSnackBar(
                                    'Education updated successfully', context,
                                    isError: false);
                              });
                            } else {
                              showCustomSnackBar(
                                  'Failed to update education', context);
                            }
                          });
                        }
                      },
                      child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
