import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_req_model.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_res_model.dart';
import 'package:shramsansar/features/auth/data/repositories/auth_repository.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class ChangePasswordController
    extends StateNotifier<AsyncValue<ChangePasswordResModel>> {
  final AuthRepo authRepo;
  ChangePasswordController(this.authRepo) : super(const AsyncValue.loading());

  Future<bool> changePassword(ChangePasswordReqModel changePasswordReqModel,
      BuildContext context) async {
    bool flag = false;
    final result = await authRepo.changePasswordRepo(changePasswordReqModel);
    result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) {
      state = AsyncValue.data(r);

      flag = true; 
    });
    return flag;
  }
}

final changePasswordControllerProvider = StateNotifierProvider<
    ChangePasswordController, AsyncValue<ChangePasswordResModel>>((ref) {
  return ChangePasswordController(ref.read(authRepoProvider));
});
