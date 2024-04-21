import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Language'),
            TextFormField(
              controller: _languageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Language is required';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: "Language "),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _readingController,
                    decoration: const InputDecoration(hintText: "Reading "),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Reading is required';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _speakingController,
                    decoration: const InputDecoration(hintText: "Speaking "),
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _writingController,
                    decoration: const InputDecoration(hintText: "Writing "),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Writing is required';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _listeningController,
                    decoration: const InputDecoration(hintText: "Listening "),
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
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
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
