part of '../login_view.dart';

extension on LoginView {
  SizedBox _buildLogo() {
    return SizedBox(
      height: 50.h,
      width: 100.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 4.h,
            ),
            Hero(
              tag: logoHeroAnimationTag,
              child: Image.asset(
                appLogo,
                height: 24.h,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: animatedTextFontSize,
                fontFamily: animatedTextFontFamily,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    sectionTitle,
                    speed: const Duration(milliseconds: 200),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Padding _buildTextFields() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        height: 50.h,
        width: 100.w,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => AuthTextField(
                    controller: _loginViewTextEditingController
                        .emailTextEditingController,
                    hintText: emailHintText,
                    prefixIcon: Icons.email_rounded,
                    cursorColor: primaryColor,
                    textColor: primaryColor,
                    errorText: emailFieldErrorText,
                    valid: _loginViewTextEditingController.emailFieldValid,
                  )),
              SizedBox(
                height: 2.h,
              ),
              Obx(() => AuthTextField(
                    controller: _loginViewTextEditingController
                        .passwordTextEditingController,
                    hintText: passwordHintText,
                    suffixIcon: Icons.visibility_off_outlined,
                    prefixIcon: Icons.lock_rounded,
                    cursorColor: primaryColor,
                    textColor: primaryColor,
                    obscureText: true,
                    errorText: passwordFieldErrorText,
                    valid: _loginViewTextEditingController.passwordFieldValid,
                  )),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  forgotText,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Hero(
                tag: loginHeroAnimationTag,
                child: AuthButton(
                  text: loginText,
                  onPressed: () {
                    if (_loginViewTextEditingController.validateFields()) {
                      _loginButtonController.loginButtonPressed(
                        _loginViewTextEditingController
                            .emailTextEditingController.text,
                        _loginViewTextEditingController
                            .passwordTextEditingController.text,
                      );
                    }
                  },
                  textColor: CoreColor.primaryColorLight,
                  buttonColor: primaryColor,
                  borderColor: primaryColor,
                  fontSize: fontSize,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Hero(
                tag: splitWidgetHeroAnimationTag,
                child: _buildSplitWidget(),
              ),
              SizedBox(
                height: 1.h,
              ),
              Hero(
                tag: registerHeroAnimationTag,
                child: AuthButton(
                  text: registerText,
                  onPressed: () => Get.offNamed(RegisterView.id),
                  textColor: CoreColor.primaryColor,
                  buttonColor: CoreColor.primaryColorLight,
                  borderColor: CoreColor.primaryColor,
                  fontSize: fontSize,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSplitWidget() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 1,
            color: CoreColor.primaryColor,
          ),
        ),
        Expanded(
          child: Text(
            'or',
            style: TextStyle(
              color: CoreColor.primaryColor,
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            height: 1,
            color: CoreColor.primaryColor,
          ),
        ),
      ],
    );
  }
}
