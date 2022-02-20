import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/app_color.dart';
import '../../component/auth_button.dart';
import '../../controller/welcome/welcome_controller.dart';
import '../authenticate/login/login_view.dart';
import '../authenticate/register/register_view.dart';

part './extension/welcome_extension.dart';

class WelcomeView extends StatelessWidget {
  static const String id = '/welcome';

  late final WelcomeController _welcomeController;

  final String appTitle;
  final String description;
  final Color buttonColor;
  final String loginText;
  final String registerText;
  final double fontSize;
  final String backgroundImage;
  final String appLogo;
  final double animatedTextFontSize;
  final String animatedTextFontFamily;
  final List<String> animatedTextList;
  final Color appTitleColor;
  final Color descriptionColor;
  final String logoHeroAnimationTag;
  final String loginHeroAnimationTag;
  final String registerHeroAnimationTag;

  WelcomeView(
      {Key? key,
      required this.appTitle,
      required this.description,
      this.buttonColor = Colors.blue,
      this.loginText = 'Login',
      this.registerText = 'Register',
      this.fontSize = 12,
      required this.backgroundImage,
      required this.appLogo,
      this.animatedTextFontSize = 40,
      required this.animatedTextFontFamily,
      required this.animatedTextList,
      this.appTitleColor = Colors.white,
      this.descriptionColor = Colors.white,
      this.logoHeroAnimationTag = '',
      this.loginHeroAnimationTag = '',
      this.registerHeroAnimationTag = ''})
      : super(key: key) {
        _welcomeController = Get.find();
      }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildLogoAndAnimatedWidgets(),
                ),
                Expanded(
                  flex: 4,
                  child: _buildButtons(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
