import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../service/abstracts/authenticate_service.dart';
import '../../../model/core_user.dart';
import '../../../service/concretes/authenticate_adapter.dart';
import '../../../service/abstracts/core_database_service.dart';
import '../../../utility/easy_loading_theme_tool.dart';
import '../../../../service/concretes/database_adapter.dart';
import '../../../utility/shared_preference_helper.dart';
import '../../../../view/home/home_view.dart';

class RegisterButtonController extends GetxController {
  late final AuthenticateService _authenticateService;
  late final CoreDatabaseService _coreDatabaseService;

  RegisterButtonController() {
    _authenticateService = AuthenticateAdapter();
    _coreDatabaseService = DatabaseAdapter();
    EasyLoadingThemeTool.mainTheme();
  }

  void registerButtonPressed(
      final String name, final String email, final String password) async {
    EasyLoading.show();
    CoreUser? result = await _authenticateService.registerWithEmailAndPassword(
        email, password);
    await Future.delayed(const Duration(milliseconds: 3000));
    EasyLoading.dismiss();
    if (result == null) {
      Get.snackbar('Could not register!', 'Please try again.');
    } else {
      Map<String, dynamic> _userDataMap = {
        'userName': name,
        'userEmail': email,
        'userImageUrl': '',
        'registerDate': DateTime.now().millisecondsSinceEpoch,
        'fcmToken':
            await SharedPreferenceHelper.getUserFCMTokenSharedPreference() ??
                'NO TOKEN',
        'userId': '',
      };
      await _coreDatabaseService.addNewUser(_userDataMap);
      await SharedPreferenceHelper.saveUserLoggedInSharedPreference(true);
      await SharedPreferenceHelper.saveUserNameSharedPreference(name);
      await SharedPreferenceHelper.saveUserEmailSharedPreference(email);
      Get.offAllNamed(HomeView.id);
      Get.snackbar(
          'Succesfully registered!', 'Succesfully logged in to the account.');
    }
  }
}
