import 'package:ecommerce/view/cart_view.dart';
import 'package:ecommerce/view/home_view.dart';
import 'package:ecommerce/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;
  Widget _currentScreen = HomeScreen();

  int get navigatorValue => _navigatorValue;

  get currentScreen => _currentScreen;
  void changeSelectedValue(int selectedValue) {
    switch (selectedValue) {
      case 0:
        _currentScreen = HomeScreen();
        break;

      case 1:
        _currentScreen = CartView();
        break;
      case 2:
        _currentScreen = ProfileView();
    }
    _navigatorValue = selectedValue;
    update();
  }
}
