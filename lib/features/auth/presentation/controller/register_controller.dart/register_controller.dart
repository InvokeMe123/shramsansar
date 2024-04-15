import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/dashboard.dart';
import 'package:shramsansar/features/auth/data/models/login_model/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model/register_request_model.dart';
import 'package:shramsansar/features/auth/data/repositories/auth_repository.dart';

import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class RegisterController extends StateNotifier<AsyncValue<LoginResponseModel>> {
  final AuthRepo _authRepo;
  RegisterController(this._authRepo) : super(const AsyncValue.loading());

  register(
      {required RegisterRequestModel registerRequestModel,
      required BuildContext context}) async {
    final result = await _authRepo.registerRepo(registerRequestModel);
    result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);

      log("RegisterSuccess: ${r.toJson()}");
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
