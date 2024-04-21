import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/language_model/language_model.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/language_controller/language_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

class EditLanguage extends ConsumerStatefulWidget {
  final LanguageModel languageModel;
  const EditLanguage({super.key, required this.languageModel});

  @override
  ConsumerState<EditLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends ConsumerState<EditLanguage> {
  final _formKey = GlobalKey<FormState>();

  // 5 text editing controller
  final _languageController = TextEditingController();
  final _readingController = TextEditingController();
  final _writingController = TextEditingController();
  final _speakingController = TextEditingController();
  final _listeningController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _languageController.text = widget.languageModel.name;
    _readingController.text = widget.languageModel.reading;
    _writingController.text = widget.languageModel.writing;
    _speakingController.text = widget.languageModel.speaking;
    _listeningController.text = widget.languageModel.listening;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Container(
          padding: const EdgeInsets.all(3),
          width: MediaQuery.sizeOf(context).width,
          height: 30,
          decoration: BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
          child: Row(
            children: [
              Text(
                'Edit Language',
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
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _languageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Language is required';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Language ",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(7),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5))),
            ),
            SizedBox(
              height: 1.2.h,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _readingController,
                    decoration: const InputDecoration(
                        labelText: "Reading ",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(7),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Reading is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _speakingController,
                    decoration: const InputDecoration(
                        labelText: "Speaking ",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(7),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Speaking is required';
                      }
                      return null;
                    },
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
                    controller: _writingController,
                    decoration: const InputDecoration(
                        labelText: "Writing ",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(7),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Writing is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _listeningController,
                    decoration: const InputDecoration(
                        labelText: "Listening ",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(7),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: .5))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Listening is required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.2.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(20.w, 4.h),
                    fixedSize: Size(20.w, 4.h),
                    maximumSize: Size(20.w, 4.h),
                    backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(languageControllerProvider.notifier)
                        .updateLanguage(
                          LanguageModel(
                            id: widget.languageModel.id,
                            name: _languageController.text,
                            speaking: _speakingController.text,
                            reading: _readingController.text,
                            writing: _writingController.text,
                            listening: _listeningController.text,
                          ),
                        )
                        .then((value) {
                      if (value) {
                        ref
                            .read(profileControllerProvider.notifier)
                            .getMyProfile()
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Failed to add language'),
                        ));
                      }
                    });
                  }
                },
                child:
                    const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
