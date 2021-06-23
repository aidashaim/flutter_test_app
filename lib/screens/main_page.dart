import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/controller.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainPage extends StatelessWidget {
  final Controller _controller = Get.put(Controller());

  void showSnackbar() {
    Get.snackbar('Snackbar', 'Вверх',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blue);
  }

  void onSliding(double position) {
    _controller.slide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [circleWidget(), mainBlocWidget()],
      ),
    );
  }

  Widget circleWidget() {
    return GetBuilder<Controller>(
        init: Controller(),
        builder: (_) => Positioned(
              top: -100.0,
              left: -100.0,
              child: Transform.rotate(
                  angle: _.circlePosition.value,
                  child: SvgPicture.asset(
                    'assets/circle.svg',
                    width: 300.0,
                  )),
            ));
  }

  Widget mainBlocWidget() {
    return SlidingUpPanel(
        controller: _controller.panelController,
        onPanelOpened: () => showSnackbar(),
        onPanelSlide: (position) => onSliding(position),
        minHeight: MediaQuery.of(Get.context).size.height * 0.5,
        maxHeight: MediaQuery.of(Get.context).size.height,
        color: Color(0xFFCCCCCC),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        panel: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowItem(0.7),
                  rowItem(0.9),
                  rowItem(0.55),
                ],
              ),
            ),
            listWidget()
          ],
        ));
  }

  Widget listWidget() {
    return Container(
      height: 80.0,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: ListView.builder(
          controller: _controller.scrollController,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return blocItem(index);
          }),
    );
  }

  Widget rowItem(double width) {
    return Container(
      width: (MediaQuery.of(Get.context).size.width - 40.0) * width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 3),
            blurRadius: 7,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Widget blocItem(int index) {
    return InkWell(
        onTap: () => _controller.setIndex(index),
        child: GetBuilder<Controller>(
          init: Controller(),
          builder: (_) => Container(
            width: 80.0,
            decoration: BoxDecoration(
              color: _.selectedBloc == index ? Colors.blue : Colors.white,
              border: Border.all(color: Color(0xFF505050), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
          ),
        ));
  }
}
