import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_req_model.dart';
import 'package:shramsansar/features/auth/presentation/controller/change_password_controller/change_password_controller.dart';
import 'package:shramsansar/utils/custom_form/custom_form.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword1 = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;

  Icon visible = Icon(Icons.visibility);
  Icon notvisible = Icon(Icons.visibility_off);

  void toggleVisibilty1() {
    setState(() {
      isVisible1 = !isVisible1;
    });
  }

  void toggleVisibilty2() {
    setState(() {
      isVisible2 = !isVisible2;
    });
  }

  void toggleVisibilty3() {
    setState(() {
      isVisible3 = !isVisible3;
    });
  }

  @override
  Widget build(BuildContext context) {
    var update = ref.watch(changePasswordControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomTextformFormField(
                issuffixIconrequired: IconButton(
                    onPressed: () => toggleVisibilty1(),
                    icon: !isVisible1 ? visible : notvisible),
                obscureText: isVisible1,
                hintText: 'Current Password',
                keyboardType: TextInputType.visiblePassword,
                controller: currentPassword,
                textInputAction: TextInputAction.next),
            const SizedBox(
              height: 10,
            ),
            CustomTextformFormField(
              issuffixIconrequired: IconButton(
                  onPressed: () => toggleVisibilty2(),
                  icon: !isVisible2 ? visible : notvisible),
              obscureText: isVisible2,
              keyboardType: TextInputType.visiblePassword,
              controller: newPassword1,
              textInputAction: TextInputAction.next,
              hintText: 'New Password',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextformFormField(
              issuffixIconrequired: IconButton(
                  onPressed: () => toggleVisibilty3(),
                  icon: !isVisible3 ? visible : notvisible),
              obscureText: isVisible3,
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPassword,
              textInputAction: TextInputAction.done,
              hintText: 'Confirm Password',
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (currentPassword.text.isEmpty) {
                  showCustomSnackBar(
                      'Current password can\'t be empty', context);
                } else if (newPassword1.text.isEmpty) {
                  showCustomSnackBar('New password can\'t be empty', context);
                } else if (confirmPassword.text.isEmpty) {
                  showCustomSnackBar('cant be empty', context);
                } else if (newPassword1.text != confirmPassword.text) {
                  showCustomSnackBar(
                      'New password and confirm password don\'t match',
                      context);
                }
                String password;
                String newPassword;
                String passwordConfirmation;

                password = currentPassword.text;
                newPassword = newPassword1.text;
                passwordConfirmation = confirmPassword.text;

                ChangePasswordReqModel changePasswordReqModel =
                    ChangePasswordReqModel(
                        currentpassword: password,
                        password: newPassword,
                        passwordConfirmation: passwordConfirmation);
                update
                    .changePassword(changePasswordReqModel, context)
                    .then((success) {
                  if (success) {
                    currentPassword.clear();
                    newPassword1.clear();
                    confirmPassword.clear();
                    showCustomSnackBar('Password Sucessfully updated', context,
                        isError: false);
                  } else {
                    showCustomSnackBar('Sorry error occurred', context,
                        isError: true);
                  }
                });
              },
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
            )
          ],
        ),
      ),
    );
  }
}
