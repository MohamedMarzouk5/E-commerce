import 'package:ecommerce/core/view_model/auth_view_model.dart';
import 'package:ecommerce/core/view_model/control_view_model.dart';
import 'package:ecommerce/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    //زي ال get builder بس من غير ال controller
    return Obx(
      () {
        return (Get.find<AuthViewModel>().user != null)
            ? GetBuilder<ControlViewModel>(
                //init بديها الكنترولر بتاعي
                init: ControlViewModel(),
                builder: (controller) => Scaffold(
                  bottomNavigationBar: bottomNavigationBar(),
                  body: controller.currentScreen,
                ),
              )
            : LoginScreen();
      },
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: Get.find(),
      builder: (controller) => BottomNavigationBar(
        //يبدا منين
        currentIndex: controller.navigatorValue,
        items: [
          BottomNavigationBarItem(
            //علشان لما يدوس عليها تظهر الكلام من غير ايقونه
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text('Explore'),
            ),
            label: '',
            icon: Image.asset(
              'assets/images/Icon_Explore.png',
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
          BottomNavigationBarItem(
            //علشان لما يدوس عليها تظهر الكلام من غير ايقونه
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text('Cart'),
            ),
            label: '',
            icon: Image.asset(
              'assets/images/Icon_Cart.png',
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
          BottomNavigationBarItem(
            //علشان لما يدوس عليها تظهر الكلام من غير ايقونه
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text('Account'),
            ),
            label: '',
            icon: Image.asset(
              'assets/images/Icon_User.png',
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
        ],
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        elevation: 0.0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }
}
