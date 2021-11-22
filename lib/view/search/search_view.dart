import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vchat/component/search_result_tile.dart';
import 'package:vchat/constant/app_color.dart';
import 'package:vchat/controller/search/search_controller.dart';

part './extension/search_extension.dart';

class SearchView extends StatelessWidget {
  static const String id = '/search';

  final SearchController _searchController = Get.find();

  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildResultList(),
      ),
    );
  }

  GetBuilder<SearchController> _buildResultList() {
    return GetBuilder<SearchController>(
        init: SearchController(),
        initState: (_) {},
        builder: (_) {
          return _userList();
        });
  }
}
