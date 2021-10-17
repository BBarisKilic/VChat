import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vchat/constant/app_asset.dart';
import 'package:vchat/constant/app_color.dart';
import 'package:vchat/constant/app_hero_tag.dart';
import 'package:vchat/constant/app_string.dart';
import 'package:vchat/controller/chat/chat_controller.dart';
import 'package:vchat/controller/chat/player_controller.dart';
import 'package:vchat/controller/search/search_controller.dart';
import 'package:vchat/controller/home/chat_list_controller.dart';
import 'package:vchat/core/controller/authenticate/login/login_button_controller.dart';
import 'package:vchat/core/controller/authenticate/login/login_text_editing_controller.dart';
import 'package:vchat/core/controller/authenticate/register/register_button_controller.dart';
import 'package:vchat/core/controller/authenticate/register/register_text_editing_controller.dart';
import 'package:vchat/core/controller/welcome/welcome_controller.dart';
import 'package:vchat/core/core.dart';
import 'package:vchat/core/view/authenticate/login/login_view.dart';
import 'package:vchat/core/view/authenticate/register/register_view.dart';
import 'package:vchat/core/view/welcome/welcome_view.dart';
import 'package:vchat/utility/theme/app_theme.dart';
import 'package:vchat/view/chat/chat_view.dart';
import 'package:vchat/view/home/home_view.dart';
import 'package:vchat/view/search/search_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(VChatApp());
}

class VChatApp extends StatelessWidget with Core {
  VChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, __, ___) {
      return GetMaterialApp(
        title: AppString.title,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        getPages: createGetPagesList(),
        initialRoute: WelcomeView.id,
        initialBinding: BindingsBuilder(() => dependencies()),
        builder: EasyLoading.init(),
      );
    });
  }

  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
    Get.lazyPut<LoginTextEditingController>(() => LoginTextEditingController(),
        fenix: true);
    Get.lazyPut<LoginButtonController>(() => LoginButtonController(),
        fenix: true);
    Get.lazyPut<RegisterTextEditingController>(
        () => RegisterTextEditingController(),
        fenix: true);
    Get.lazyPut<RegisterButtonController>(() => RegisterButtonController(),
        fenix: true);
  }

  @override
  List<GetPage> createGetPagesList() {
    final List<GetPage> _getPageList = <GetPage>[];
    _getPageList.add(GetPage(
      name: WelcomeView.id,
      page: () => WelcomeView(
        appTitle: AppString.title,
        description: AppString.description,
        buttonColor: AppColor.primaryColor,
        fontSize: 16,
        backgroundImage: AppAsset.welcomeBackground,
        animatedTextFontFamily: "AmaticSC",
        animatedTextList: const <String>[
          AppString.welcomeAnimatedTextOne,
          AppString.welcomeAnimatedTextTwo,
          AppString.welcomeAnimatedTextThree,
        ],
        appLogo: AppAsset.vChatLogo,
        descriptionColor: AppColor.primaryColorDark,
        logoHeroAnimationTag: AppHeroTag.appLogo,
        loginHeroAnimationTag: AppHeroTag.loginButton,
        registerHeroAnimationTag: AppHeroTag.registerButton,
      ),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ));
    _getPageList.add(GetPage(
      name: LoginView.id,
      page: () => LoginView(
        backgroundImage: AppAsset.welcomeBackground,
        primaryColor: AppColor.primaryColor,
        fontSize: 16,
        appLogo: AppAsset.vChatLogo,
        animatedTextFontFamily: "AmaticSC",
        logoHeroAnimationTag: AppHeroTag.appLogo,
        loginHeroAnimationTag: AppHeroTag.loginButton,
        registerHeroAnimationTag: AppHeroTag.registerButton,
        splitWidgetHeroAnimationTag: AppHeroTag.splitWidget,
        sectionTitle: "LOGIN",
        emailHintText: "Email",
        passwordHintText: "Password",
        forgotText: "Forgot Password?",
      ),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ));
    _getPageList.add(GetPage(
      name: RegisterView.id,
      page: () => RegisterView(
        backgroundImage: AppAsset.welcomeBackground,
        primaryColor: AppColor.primaryColor,
        fontSize: 16,
        appLogo: AppAsset.vChatLogo,
        animatedTextFontFamily: "AmaticSC",
        logoHeroAnimationTag: AppHeroTag.appLogo,
        loginHeroAnimationTag: AppHeroTag.loginButton,
        registerHeroAnimationTag: AppHeroTag.registerButton,
        splitWidgetHeroAnimationTag: AppHeroTag.splitWidget,
        sectionTitle: "REGISTER",
        nameHintText: "Name",
        emailHintText: "Email",
        passwordHintText: "Password",
      ),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ));
    _getPageList.add(GetPage(
      name: HomeView.id,
      page: () => HomeView(),
      binding: BindingsBuilder(() => Get.lazyPut<ChatListController>(
          () => ChatListController(),
          fenix: true)),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ));
    _getPageList.add(GetPage(
      name: ChatView.id,
      page: () => ChatView(),
      bindings: [
        BindingsBuilder(() =>
            Get.lazyPut<ChatController>(() => ChatController(), fenix: true)),
        BindingsBuilder(() => Get.lazyPut<PlayerController>(
            () => PlayerController(),
            fenix: true)),
      ],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ));
    _getPageList.add(GetPage(
      name: SearchView.id,
      page: () => SearchView(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<SearchController>(() => SearchController(), fenix: true)),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ));
    return _getPageList;
  }
}
