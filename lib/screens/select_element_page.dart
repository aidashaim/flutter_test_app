import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/controller.dart';
import 'package:get/get.dart';

class SelectElementPage extends GetView<Controller> {
  final Controller _controller = Get.put(Controller());
  final int index = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                focusNode: _controller.indexFocus,
                controller: _controller.indexTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                )),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LimitRangeTextInputFormatter(1, 10),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                onPressed: () => _controller.saveIndex(),
                child: Text(
                  "Сохранить",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      var value = int.parse(newValue.text);
      if (value < min) {
        return TextEditingValue(text: min.toString());
      } else if (value > max) {
        return TextEditingValue(text: max.toString());
      }
    }
    return newValue;
  }
}
