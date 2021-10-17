import 'package:get/get.dart';

abstract class Core {
  void dependencies();
  List<GetPage> createGetPagesList();
}
