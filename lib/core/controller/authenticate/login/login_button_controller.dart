import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vchat/core/service/authenticate_service.dart';
import 'package:vchat/core/utility/easy_loading_theme_tool.dart';
import 'package:vchat/service/database_service.dart';
import 'package:vchat/core/utility/shared_preference_helper.dart';
import 'package:vchat/view/home/home_view.dart';

class LoginButtonController extends GetxController {
  final AuthenticateService _authenticateService = AuthenticateService();

  LoginButtonController() {
    EasyLoadingThemeTool.mainTheme();
  }

  void loginButtonPressed(final String _email, final String _password) async {
    EasyLoading.show();
    User? _user = await _authenticateService.signInWithEmailAndPassword(
        _email, _password);
    //await Future.delayed(const Duration(milliseconds: 3000));
    EasyLoading.dismiss();
    if (_user == null) {
      Get.snackbar('Could not login!', 'Please check your email and password.');
    } else {
      QuerySnapshot userInfoSnapshot =
          await DatabaseService().getUserDetails(_email);
      await SharedPreferenceHelper.saveUserLoggedInSharedPreference(true);
      await SharedPreferenceHelper.saveUserNameSharedPreference(
          userInfoSnapshot.docs[0].get('userName'));
      await SharedPreferenceHelper.saveUserEmailSharedPreference(
          userInfoSnapshot.docs[0].get('userEmail'));
      Get.offAllNamed(HomeView.id);
    }
  }
}
