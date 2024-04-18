import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/auth/data/models/login_model/login_request_model.dart';
import 'package:shramsansar/features/auth/presentation/controller/auth_controller.dart';
import 'package:shramsansar/features/auth/presentation/controller/login_loading_controller.dart';
import 'package:shramsansar/features/auth/presentation/views/register/register_screen.dart';
import 'package:shramsansar/utils/custom_form/custom_form.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  String device_token =
      'fiRiB9DySGO4dzQG8-Qu7y:APA91bGIoNhOM1Ub8a6u7TN3SDd1DO3HahpS8DIqW0p_vf5eJQgICh5Byt6F8CqjGJLdWof2IadqdSXwVYxZfEyTCY-pB2zLs6u9ZtyQSWSnQ5w-RAIa61czHzJ-FqxGdtMyt7HnUQ_A';
  String token = '';
  bool isVisible = false;
  Icon visible = Icon(Icons.visibility);
  Icon notVisible = Icon(Icons.visibility_off_outlined);

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token').toString();
    log(token);
    LoginRequestModel loginRequestModel = LoginRequestModel(
        device_token: device_token,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    if (formKey.currentState!.validate()) {
      ref.read(loginloadingProvider.notifier).update((state) => true);
      log(device_token);
      await ref
          .read(authControllerProvider.notifier)
          .login(loginRequestModel, context, token);
    } else {
      showCustomSnackBar('Wrong password', context);
    }
    ref.read(loginloadingProvider.notifier).update((state) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const Text('Shramsansar'),
              const Text("All the works in same place"),
              const Text("Log In"),
              CustomTextformFormField(
                keyboardType: TextInputType.name,
                controller: _emailController,
                textInputAction: TextInputAction.next,
                isLablerequire: true,
                hintText: 'Enter Email',
              ),
              CustomTextformFormField(
                obscureText: isVisible,
                issuffixIconrequired: GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: isVisible ? notVisible : visible,
                ),
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                isLablerequire: true,
                hintText: 'Enter Password',
              ),
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        print('in forgot password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColorConst.TEXT_BLACK_COLOR),
                      ))
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius
                          .zero, // Set the border radius to zero for a rectangular shape
                    ),
                    backgroundColor: AppColorConst.BUTTON_BLUE_COLOR),
                onPressed: () async {
                  await login();
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: AppColorConst.WHAIT),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  normalNav(context, const RegisterScreen());
                },
                child: Container(
                  child: const Text("Create New Account"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
