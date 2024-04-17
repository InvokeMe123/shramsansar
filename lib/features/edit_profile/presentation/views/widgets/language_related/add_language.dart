import 'package:flutter/material.dart';

class AddLanguage extends StatefulWidget {
  const AddLanguage({super.key});

  @override
  State<AddLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  final _formKey = GlobalKey<FormState>();

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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Language is required';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Language "),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Reading "),
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
                    decoration: InputDecoration(hintText: "Speaking "),
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
                    decoration: InputDecoration(hintText: "Writing "),
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
                    decoration: InputDecoration(hintText: "Listening "),
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
                    // Navigator.of(context).pop();
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
