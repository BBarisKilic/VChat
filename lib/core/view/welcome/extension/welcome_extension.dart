part of '../welcome_view.dart';

extension on WelcomeView {
  Padding _buildLogoAndAnimatedWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Hero(
            tag: logoHeroAnimationTag,
            child: Image.asset(
              appLogo,
              height: 20.h,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          DefaultTextStyle(
            style: TextStyle(
                fontSize: animatedTextFontSize,
                fontFamily: animatedTextFontFamily,
                color: AppColor.primaryColorDark),
            child: AnimatedTextKit(
                repeatForever: true,
                pause: Duration.zero,
                animatedTexts: _buildRotateAnimatedText(animatedTextList)),
          ),
        ],
      ),
    );
  }

  List<RotateAnimatedText> _buildRotateAnimatedText(
      List<String> _animatedTextList) {
    final List<RotateAnimatedText> _rotateAnimatedTextList =
        <RotateAnimatedText>[];
    for (final String _text in _animatedTextList) {
      _rotateAnimatedTextList.add(RotateAnimatedText(_text));
    }
    return _rotateAnimatedTextList;
  }

  Padding _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            appTitle,
            style: TextStyle(
              color: appTitleColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            description,
            style: TextStyle(
              color: descriptionColor,
              fontSize: 12.sp,
            ),
          ),
          const Expanded(child: SizedBox()),
          Hero(
            tag: loginHeroAnimationTag,
            child: AuthButton(
              onPressed: () => Get.toNamed(LoginView.id),
              buttonColor: Colors.white,
              borderColor: Colors.white,
              textColor: buttonColor,
              text: loginText,
              fontSize: fontSize,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Hero(
            tag: registerHeroAnimationTag,
            child: AuthButton(
              onPressed: () => Get.toNamed(RegisterView.id),
              buttonColor: buttonColor,
              borderColor: Colors.white,
              textColor: Colors.white,
              text: registerText,
              fontSize: fontSize,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
