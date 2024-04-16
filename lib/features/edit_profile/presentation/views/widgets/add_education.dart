import 'package:flutter/material.dart';
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

  String ed = 'Education';
  String? educ;

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    return DateFormat('yyyy-MM-dd').format(date);
  }

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
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
                    child: const Icon(Icons.close, color: Colors.white))
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
                    child: DropdownButton<String>(
                      hint: const Text('Education'),
                      value: educ,
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
                  const Text('Education Board'),
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
                  const Text('Program'),
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
                  const Text('Institute'),
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
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Graduate Year'),
                    Container(
                        height: 40,
                        width: MediaQuery.sizeOf(context).width * 0.38,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(_formatDate(selectedDate).isEmpty
                            ? 'Select Date'
                            : _formatDate(selectedDate))),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Column(
                children: [
                  const Text('Obtained Marks'),
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
              const Spacer(),
              TextButton(
                  onPressed: () {
                    if (program.text.isEmpty ||
                        educationBoard.text.isEmpty ||
                        institute.text.isEmpty ||
                        _formatDate(selectedDate).isEmpty) {
                      return showCustomSnackBar(
                          'Fields Cant be empty', context);
                    }
                    EducationReqModel educationReqModel = EducationReqModel(
                        level_id: levelID.toString(),
                        levelName: widget.educationLevel.elementAt(levelID - 1),
                        program: program.text,
                        board: educationBoard.text,
                        institute: institute.text,
                        graduation_year: _formatDate(selectedDate),
                        marks_secured: obtainedMarks.text);

                    ref
                        .read(profileControllerProvider.notifier)
                        .addEducation(
                            profileModel: widget.profileModel,
                            educationReqModel: educationReqModel)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pop();
                      } else {
                        showCustomSnackBar('Failed to add education', context);
                      }
                    });
                  },
                  child: const Text('Save'))
            ],
          )
        ],
      ),
    );
  }
}
