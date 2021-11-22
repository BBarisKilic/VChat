import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../model/core_user.dart';
import '../../../service/authenticate_service.dart';
import '../../../service/core_database_service.dart';
import '../../../utility/easy_loading_theme_tool.dart';
import '../../../../service/database_service.dart';
import '../../../utility/shared_preference_helper.dart';
import '../../../../view/home/home_view.dart';

class RegisterButtonController extends GetxController {
  final AuthenticateService _authenticateService = AuthenticateService();
  final CoreDatabaseService _coreDatabaseService = DatabaseService();

  RegisterButtonController() {
    EasyLoadingThemeTool.mainTheme();
  }

  void registerButtonPressed(
      final String _name, final String _email, final String _password) async {
    EasyLoading.show();
    CoreUser? result = await _authenticateService.registerWithEmailAndPassword(
        _email, _password);
    await Future.delayed(const Duration(milliseconds: 3000));
    EasyLoading.dismiss();
    if (result == null) {
      Get.snackbar('Could not register!', 'Please try again.');
    } else {
      Map<String, dynamic> _userDataMap = {
        'userName': _name,
        'userEmail': _email,
        'userImageUrl': '',
        'registerDate': DateTime.now().millisecondsSinceEpoch,
        'fcmToken':
            await SharedPreferenceHelper.getUserFCMTokenSharedPreference() ??
                'NO TOKEN',
        'userId': '',
      };
      await _coreDatabaseService.addNewUser(_userDataMap);
      await SharedPreferenceHelper.saveUserLoggedInSharedPreference(true);
      await SharedPreferenceHelper.saveUserNameSharedPreference(_name);
      await SharedPreferenceHelper.saveUserEmailSharedPreference(_email);
      Get.offAllNamed(HomeView.id);
      Get.snackbar(
          'Succesfully registered!', 'Succesfully logged in to the account.');
    }
  }
}
