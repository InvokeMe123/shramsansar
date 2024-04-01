import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/dashboard.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_request_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model.dart/register_request_model.dart';
import 'package:shramsansar/features/auth/data/repositories/auth_repository.dart';
import 'package:shramsansar/features/auth/presentation/controller/auth_state.dart';
import 'package:shramsansar/features/auth/presentation/views/login/loginScreen.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthRepo authRepo;
  final DbClient dbClient;
  AuthController({required this.authRepo, required this.dbClient})
      : super(const AuthState.loading()) {
    checkLogin();
  }
  checkLogin() async {
    final String dbResult = await dbClient.getData(dbKey: "token");
    // log(dbResult);

    return dbResult.isEmpty
        ? state = const AuthState.loggedOut()
        : state = AuthState.loggedIn(LoginResponseModel.fromJson(dbResult));
  }

  login(LoginRequestModel loginRequestModel, BuildContext context,
      String token) async {
    final result = await authRepo.loginRepo(loginRequestModel, token);
    result.fold((l) {
      log('error');
      showCustomSnackBar("Your email or password do not match", context);
    }, (r) async {
      showCustomSnackBar("You are logged In", context, isError: false);

      state = AuthState.loggedIn(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, const Dashboard());
      }
    });
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
      authRepo: ref.read(authRepoProvider),
      dbClient: ref.read(dbClientprovider));
});
