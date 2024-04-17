import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/social_accounts_model.dart';

class AddSocialMedia extends ConsumerStatefulWidget {
  final SocialAccountsModel socialAccountsModel;
  const AddSocialMedia({super.key, required this.socialAccountsModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSocialMediaState();
}

class _AddSocialMediaState extends ConsumerState<AddSocialMedia> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers = widget.socialAccountsModel.accounts
        .map((e) => TextEditingController())
        .toList();
  }

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
                labelText:
                    widget.socialAccountsModel.accounts[a].name.toString(),
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
