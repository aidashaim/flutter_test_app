import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Controller extends GetxController {
  var selectedBloc = -1.obs;
  var circlePosition = 0.0.obs;
  TextEditingController indexTextController;
  ScrollController scrollController;
  FocusNode indexFocus;
  PanelController panelController;

  @override
  void onInit() {
    indexTextController = TextEditingController();
    scrollController = ScrollController();
    indexFocus = FocusNode();
    panelController = PanelController();
    super.onInit();
  }

  void saveIndex() async {
    String _ind = indexTextController.text;
    if (_ind.isNotEmpty)
      selectedBloc = int.parse(_ind);
    else
      selectedBloc = -1;
    update();
    Get.back();
    scrollController.animateTo(100.0 * double.parse(_ind != '' ? _ind : '0'),
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void setIndex(int index) {
    indexTextController.text = index.toString();
    Get.toNamed('/select_element');
    indexFocus.requestFocus();
    update();
  }

  void slide() {
    circlePosition.value = panelController.panelPosition / 2;
    update();
  }

  @override
  void onClose() {
    indexTextController?.dispose();
    scrollController?.dispose();
    indexFocus?.dispose();
    super.onClose();
  }
}
