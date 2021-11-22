import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../component/auth_button.dart';
import '../../../component/auth_text_field.dart';
import '../../../utility/clipper.dart';
import '../../../constant/core_color.dart';
import '../../../controller/authenticate/login/login_button_controller.dart';
import '../../../controller/authenticate/login/login_text_editing_controller.dart';
import '../register/register_view.dart';

part './extension/login_extension.dart';

class LoginView extends StatelessWidget {
  static const String id = '/login';

  final LoginTextEditingController _loginViewTextEditingController = Get.find();
  final LoginButtonController _loginButtonController = Get.find();
  final String backgroundImage;
  final Color primaryColor;
  final String loginText;
  final String registerText;
  final double fontSize;
  final String appLogo;
  final double animatedTextFontSize;
  final String animatedTextFontFamily;
  final String sectionTitle;
  final String logoHeroAnimationTag;
  final String loginHeroAnimationTag;
  final String registerHeroAnimationTag;
  final String splitWidgetHeroAnimationTag;
  final String emailHintText;
  final String passwordHintText;
  final String forgotText;
  final String emailFieldErrorText;
  final String passwordFieldErrorText;

  LoginView({
    Key? key,
    required this.backgroundImage,
    this.primaryColor = Colors.white,
    this.loginText = 'Login',
    this.registerText = 'Register',
    this.fontSize = 12,
    required this.appLogo,
    this.animatedTextFontSize = 40,
    required this.animatedTextFontFamily,
    this.sectionTitle = '',
    this.logoHeroAnimationTag = '',
    this.loginHeroAnimationTag = '',
    this.registerHeroAnimationTag = '',
    this.splitWidgetHeroAnimationTag = '',
    this.emailHintText = '',
    this.passwordHintText = '',
    this.forgotText = '',
    this.emailFieldErrorText = '',
    this.passwordFieldErrorText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreColor.primaryColorLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: Clipper(id),
              child: _buildLogo(),
            ),
            _buildTextFields(),
          ],
        ),
      ),
    );
  }
}
