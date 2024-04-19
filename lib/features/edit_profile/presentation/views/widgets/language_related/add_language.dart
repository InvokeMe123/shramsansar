import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/language_model/language_model.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/language_controller/language_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

class AddLanguage extends ConsumerStatefulWidget {
  const AddLanguage({super.key});

  @override
  ConsumerState<AddLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends ConsumerState<AddLanguage> {
  final _formKey = GlobalKey<FormState>();

  // 5 text editing controller
  final _languageController = TextEditingController();
  final _readingController = TextEditingController();
  final _writingController = TextEditingController();
  final _speakingController = TextEditingController();
  final _listeningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Language'),
            TextFormField(
              controller: _languageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Language is required';
                }
                return null;
              },
              decoration: InputDecoration(labelText: "Language "),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _readingController,
                    decoration: InputDecoration(labelText: "Reading "),
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
                    decoration: InputDecoration(labelText: "Speaking "),
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
                    decoration: InputDecoration(labelText: "Writing "),
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
                    decoration: InputDecoration(labelText: "Listening "),
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
                        .addLanguage(
                          LanguageModel(
                            id: 0, // id is not required when adding
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
