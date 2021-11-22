part of '../chat_view.dart';

extension on ChatView {
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              highlightColor: Colors.transparent,
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.primaryColor,
                size: 32.0,
              ),
            ),
            Hero(
              tag: AppHeroTag.profileImage + (_chatController.userName ?? ''),
              child: Image.asset(
                AppAsset.anonymLogo,
                height: 5.h,
              ),
            ),
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
                    _chatController.userName ?? '',
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
          ],
        ),
      ),
    );
  }

  GetBuilder<ChatController> _chatMessages() {
    return GetBuilder<ChatController>(
      init: ChatController(),
      initState: (_) {},
      builder: (_) {
        return StreamBuilder(
          stream: _chatController.chats,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var reversedData = snapshot.data?.docs.reversed;
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return MessageTile(
                          id: index,
                          chatRoomId: _chatController.chatRoomId!,
                          duration:
                              reversedData!.elementAt(index).get('duration'),
                          sendBy: reversedData.elementAt(index).get('sendBy'),
                          time: reversedData.elementAt(index).get('time'),
                          sendByCurrentUser: AppConfig.currentUserName ==
                              reversedData.elementAt(index).get('sendBy'),
                          messageTileWidth:
                              MessageTileWidthCalculator.calculate(Duration(
                                  seconds: reversedData
                                      .elementAt(index)
                                      .get('duration'))));
                    },
                  )
                : Container();
          },
        );
      },
    );
  }

  SafeArea _buildRecordArea() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Obx(() => _chatController.showBackButton
                      ? InkWell(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          highlightColor: Colors.transparent,
                          onTap: () => _chatController.backButtonPressed(),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 32,
                            color: AppColor.primaryIconColorLight,
                          ),
                        )
                      : const SizedBox(width: 32)),
                  Flexible(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _chatController.isRecording
                                ? Colors.red
                                : AppColor.primaryIconColorLight,
                            width: 1.5.w,
                            style: BorderStyle.solid),
                      ),
                      child: ClipOval(child: _buildEffectButtons()),
                    ),
                  ),
                  Obx(() => _chatController.showForwardButton
                      ? InkWell(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          highlightColor: Colors.transparent,
                          onTap: () => _chatController.forwardButtonPressed(),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 32,
                            color: AppColor.primaryIconColorLight,
                          ),
                        )
                      : const SizedBox(width: 32)),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Obx(
            () => Text(
              _chatController.effectLabel,
              style: const TextStyle(
                color: AppColor.primaryTextColorLight,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }

  Obx _buildEffectButtons() {
    return Obx(
      () => PageView.builder(
        itemCount: _chatController.effects.length,
        controller: _chatController.pageController,
        onPageChanged: (i) => _chatController.onPageChanged(i),
        itemBuilder: (context, i) {
          return Transform.scale(
            scale: 1,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Obx(() {
                  return GestureDetector(
                    onTapDown: (_) => _chatController.recordSound(),
                    onTapCancel: () => _chatController.uploadSound(),
                    onTapUp: (_) => _chatController.uploadSound(),
                    child: Image.asset(
                      _chatController.effects[i].imagePath as String,
                      fit: BoxFit.cover,
                      height: 10.h,
                      width: 10.h,
                      alignment:
                          Alignment(-_chatController.pageOffset.abs() + i, 0),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
