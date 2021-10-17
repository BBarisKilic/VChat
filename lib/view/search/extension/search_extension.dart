part of '../search_view.dart';

extension on SearchView {
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
                    "Search",
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
      bottom: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 0,
        title: _buildSearchBar(),
      ),
    );
  }

  Container _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController.searchEditingController,
              cursorColor: AppColor.primaryTextColor,
              style: const TextStyle(
                color: AppColor.primaryTextColor,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                  hintText: "Search Username...",
                  hintStyle: TextStyle(
                    color: AppColor.primaryTextColor,
                    fontSize: 18,
                  ),
                  border: InputBorder.none),
            ),
          ),
          GestureDetector(
            onTap: () {
              _searchController.initiateSearch();
            },
            child: const Icon(
              Icons.search,
              color: AppColor.primaryColor,
              size: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget _userList() {
    return _searchController.haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _searchController.searchResultSnapshot?.docs.length,
            itemBuilder: (context, index) {
              return SearchResultTile(
                userName: _searchController.searchResultSnapshot?.docs[index]
                    .get("userName"),
                userEmail: _searchController.searchResultSnapshot?.docs[index]
                    .get("userEmail"),
              );
            })
        : Container();
  }
}
