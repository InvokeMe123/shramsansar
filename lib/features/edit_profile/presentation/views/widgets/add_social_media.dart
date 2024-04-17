import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/add_social_accounts.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/social_accounts_model.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/social_accounts_controller/social_accounts_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';

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
              onPressed: () {
                final model = AddSocialAccountsModel(
                  accounts: _controllers
                      .where((e) =>
                          e.text.isNotEmpty) // Filter out empty e.text values
                      .map((e) {
                    return Accounts(
                      name: widget.socialAccountsModel
                          .accounts[_controllers.indexOf(e)].name,
                      url: e.text,
                    );
                  }).toList(),
                );

                if (model.accounts!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please enter at least one social media account'),
                    ),
                  );
                  return;
                }

                ref
                    .read(socialAccountsControllerProvider.notifier)
                    .addSocialAccounts(model)
                    .then((value) {
                  if (value) {
                    ref
                        .read(profileControllerProvider.notifier)
                        .getMyProfile()
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to save social media accounts'),
                      ),
                    );
                  }
                });
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
