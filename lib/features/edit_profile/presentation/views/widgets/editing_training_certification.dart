
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/training_certification_controller/training_certification_controller.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class EditTrainingCertificate extends ConsumerStatefulWidget {
  Trainings trainings;
  EditTrainingCertificate({super.key, required this.trainings});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditTrainingCertificateState();
}

class _EditTrainingCertificateState
    extends ConsumerState<EditTrainingCertificate> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.trainings.title!;
    provider.text = widget.trainings.provider!;
    duration.text = widget.trainings.duration!;
    details.text = widget.trainings.details!;

    year.text = widget.trainings.year!;
    fileName = widget.trainings.file ?? '';
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
                    'Edit Training',
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
                      const Text('Title *'),
                      const SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                        controller: title,
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
                                borderSide: BorderSide(
                                    color: Colors.black, width: .5))),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Provider *'),
                              const SizedBox(
                                height: 3,
                              ),
                              TextFormField(
                                controller: provider,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter training provider';
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
                              const Text('Duration *'),
                              const SizedBox(
                                height: 3,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter duration';
                                  }
                                  return null;
                                },
                                controller: duration,
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
                                controller: year,
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
                                      year.text = _formatDate(picked);
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Details *'),
                              const SizedBox(
                                height: 3,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter details';
                                  }
                                  return null;
                                },
                                controller: details,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    isDense: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(7),
                                    constraints: BoxConstraints.tight(Size(
                                        MediaQuery.sizeOf(context).width * .75,
                                        100)),
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
                      const Text('Training Certification'),
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
                                    dataForm['file'] =
                                        MultipartFile.fromFileSync(filePath1,
                                            filename: fileName);
                                  }

                                  final formData = FormData.fromMap(dataForm);

                                  ref
                                      .read(
                                          trainingCertificationControllerProvider
                                              .notifier)
                                      .editTraininCertification(
                                          widget.trainings.id!, formData)
                                      .then((value) {
                                    if (value) {
                                      ref
                                          .read(profileControllerProvider
                                              .notifier)
                                          .getMyProfile()
                                          .then((value) {
                                        Navigator.pop(context);
                                        showCustomSnackBar(
                                            "Training succesfully edited.",
                                            context,
                                            isError: false);
                                      });
                                    } else {
                                      showCustomSnackBar(
                                          'Failed to edit training', context);
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
                    ]))
          ],
        ),
      ),
    );
  }
}
