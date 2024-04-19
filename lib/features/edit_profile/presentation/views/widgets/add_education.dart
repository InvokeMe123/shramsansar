import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class AddEducation extends ConsumerStatefulWidget {
  final List<String> educationLevel;
  final MyProfileModel profileModel;
  const AddEducation(
      {super.key, required this.educationLevel, required this.profileModel});

  @override
  ConsumerState<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends ConsumerState<AddEducation> {
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Container(
          height: 30,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
          child: Row(
            children: [
              const Text(
                'Add Education',
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
          padding: const EdgeInsets.all(8.0),
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
                        controller: program,
                        style: TextStyle(fontSize: 14),
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
                        controller: institute,
                        style: TextStyle(fontSize: 14),
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
                        textInputAction: TextInputAction.next,
                        controller: graduateYearController,
                        keyboardType: TextInputType.name,
                        style: TextStyle(fontSize: 14),
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
                        style: TextStyle(fontSize: 14),
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
                              .addEducation(
                                  educationReqModel: educationReqModel)
                              .then((value) {
                            if (value) {
                              ref
                                  .read(profileControllerProvider.notifier)
                                  .getMyProfile()
                                  .then((value) {
                                Navigator.pop(context);
                                showCustomSnackBar(
                                    'Education added successfully', context,
                                    isError: false);
                              });
                            } else {
                              showCustomSnackBar(
                                  'Failed to add education', context);
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
