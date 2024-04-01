import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/dashboard.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model.dart/register_request_model.dart';
import 'package:shramsansar/features/auth/data/repositories/auth_repository.dart';

import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class RegisterController extends StateNotifier<AsyncValue<LoginResponseModel>> {
  final AuthRepo authRepo;
  RegisterController(this.authRepo) : super(const AsyncValue.loading());
  register(
      {required RegisterRequestModel registerRequestModel,
      required BuildContext context,
      required String token}) async {
    final result = await authRepo.registerRepo(registerRequestModel, token);
    result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, const Dashboard());
      }
    });
  }
}

final registerControllerProvider =
    StateNotifierProvider<RegisterController, AsyncValue<LoginResponseModel>>(
        (ref) {
  return RegisterController(ref.read(authRepoProvider));
});
