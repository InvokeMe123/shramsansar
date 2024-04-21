import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/training_certification_controller/training_certification_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class AddTrainingCertificate extends ConsumerStatefulWidget {
  const AddTrainingCertificate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTrainingCertificateState();
}

class _AddTrainingCertificateState
    extends ConsumerState<AddTrainingCertificate> {
  bool isChecked = false;
  TextEditingController title = TextEditingController();
  TextEditingController provider = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController details = TextEditingController();

  final year = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.all(0),
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.all(3),
          width: MediaQuery.sizeOf(context).width,
          height: 30,
          decoration: BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
          child: Row(
            children: [
              Text(
                'Add Training',
                style: TextStyle(
                    color: AppColorConst.PRAYMARY_TEXT_COLOR, fontSize: 16),
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
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Training title';
                          }
                          return null;
                        },
                        controller: title,
                        decoration: InputDecoration(
                            labelText: 'Title *',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(7),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: provider,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter training provider';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Provider *',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(7),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5))),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter duration';
                                }
                                return null;
                              },
                              controller: duration,
                              decoration: InputDecoration(
                                  labelText: 'Duration *',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(7),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
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
                              controller: year,
                              decoration: InputDecoration(
                                  labelText: 'Start Date *',
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(7),
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
                                    year.text = _formatDate(picked);
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter details';
                                }
                                return null;
                              },
                              controller: details,
                              maxLines: 7,
                              decoration: InputDecoration(
                                  labelText: 'Details *',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(7),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: .5))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      const Text('Training Certification'),
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
                                ? AppColorConst.PRAYMARY_TEXT_COLOR
                                    .withAlpha(195)
                                : Colors.grey,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          child: Text(fileName),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(20.w, 4.h),
                                fixedSize: Size(20.w, 4.h),
                                maximumSize: Size(20.w, 4.h),
                                backgroundColor:
                                    AppColorConst.BUTTON_BLUE_COLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> dataForm = {
                                  "title": title.text,
                                  "provider": provider.text,
                                  "duration": duration.text,
                                  "year": year.text,
                                  "details": details.text,
                                };

                                if (filePath1.isNotEmpty) {
                                  dataForm['file'] = MultipartFile.fromFileSync(
                                      filePath1,
                                      filename: fileName);
                                }

                                final formData = FormData.fromMap(dataForm);

                                ref
                                    .read(
                                        trainingCertificationControllerProvider
                                            .notifier)
                                    .addTraining(formData)
                                    .then((value) {
                                  if (value) {
                                    ref
                                        .read(
                                            profileControllerProvider.notifier)
                                        .getMyProfile()
                                        .then((value) {
                                      Navigator.pop(context);
                                      showCustomSnackBar(
                                          "Training succesfully added.",
                                          context,
                                          isError: false);
                                    });
                                  } else {
                                    showCustomSnackBar(
                                        'Failed to add training', context);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
