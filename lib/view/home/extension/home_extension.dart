part of '../home_view.dart';

extension on HomeView {
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
                tag: AppHeroTag.appLogo,
                child: Image.asset(
                  AppAsset.vChatLogo,
                  height: 5.h,
                )),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                pause: Duration.zero,
                animatedTexts: [
                  ColorizeAnimatedText(
                    AppString.title,
                    speed: const Duration(milliseconds: 1000),
                    textStyle: const TextStyle(
                      color: AppColor.primaryTextColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    colors: const [
                      AppColor.primaryColor,
                      AppColor.primaryColor,
                      AppColor.primaryColorLight,
                      AppColor.primaryColorDark,
                      AppColor.primaryColor,
                      AppColor.primaryColorLight,
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              highlightColor: Colors.transparent,
              onTap: () => Get.offAllNamed(WelcomeView.id),
              child: const Icon(
                Icons.exit_to_app_rounded,
                color: AppColor.primaryColor,
                size: 32.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  GetBuilder<ChatListController> _buildChatRoomsList() {
    return GetBuilder<ChatListController>(
      init: ChatListController(),
      initState: (_) {},
      builder: (_) {
        return StreamBuilder(
          stream: _chatListController.chatRooms,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ChatRoomsTile(
                        userName: snapshot.data!.docs[index]
                            .get("chatRoomId")
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(AppConfig.currentUserName, ""),
                        chatRoomId:
                            snapshot.data?.docs[index].get("chatRoomId"),
                        lastMessageTime: snapshot.data?.docs[index]
                            .get("lastMessageTime")
                            .toString(),
                        lastMessageDuration: snapshot.data?.docs[index]
                            .get("lastMessageDuration")
                            .toString(),
                      );
                    })
                : Container();
          },
        );
      },
    );
  }
}
