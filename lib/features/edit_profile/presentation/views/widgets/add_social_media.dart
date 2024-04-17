import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSocialMedia extends ConsumerStatefulWidget {
  const AddSocialMedia({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSocialMediaState();
}

class _AddSocialMediaState extends ConsumerState<AddSocialMedia> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<String> _socialMedia = ['Facebook', 'Twitter', 'Linkedin'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int a = 0; a < _controllers.length; a++)
            TextFormField(
              controller: _controllers[a],
              decoration: InputDecoration(
                labelText: _socialMedia[a],
              ),
            ),

          // save button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
