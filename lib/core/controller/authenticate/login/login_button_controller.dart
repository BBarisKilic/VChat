import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vchat/core/service/abstracts/core_database_service.dart';
import '../../../service/abstracts/authenticate_service.dart';
import '../../../service/concretes/authenticate_adapter.dart';
import '../../../utility/easy_loading_theme_tool.dart';
import '../../../../service/concretes/database_adapter.dart';
import '../../../utility/shared_preference_helper.dart';
import '../../../../view/home/home_view.dart';

class LoginButtonController extends GetxController {
  late final AuthenticateService _authenticateService;
  late final CoreDatabaseService _coreDatabaseService;

  LoginButtonController() {
    _authenticateService = AuthenticateAdapter();
    _coreDatabaseService = DatabaseAdapter();
    EasyLoadingThemeTool.mainTheme();
  }

  void loginButtonPressed(final String email, final String password) async {
    EasyLoading.show();
    User? _user =
        await _authenticateService.signInWithEmailAndPassword(email, password);
    await Future.delayed(const Duration(milliseconds: 500));
    EasyLoading.dismiss();
    if (_user == null) {
      Get.snackbar('Could not login!', 'Please check your email and password.');
    } else {
      QuerySnapshot userInfoSnapshot =
          await _coreDatabaseService.getUserDetails(email);
      await SharedPreferenceHelper.saveUserLoggedInSharedPreference(true);
      await SharedPreferenceHelper.saveUserNameSharedPreference(
          userInfoSnapshot.docs[0].get('userName'));
      await SharedPreferenceHelper.saveUserEmailSharedPreference(
          userInfoSnapshot.docs[0].get('userEmail'));
      Get.offAllNamed(HomeView.id);
    }
  }
}
