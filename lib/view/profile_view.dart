import 'package:ecommerce/core/view_model/profile_view_model.dart';
import 'package:ecommerce/view/auth/login_screen.dart';
import 'package:ecommerce/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Container(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                image: DecorationImage(
                                    image: controller.userModel == null
                                        ? AssetImage(
                                            'assets/images/mohamed.jpeg')
                                        : controller.userModel.pic == 'default'
                                            ? AssetImage(
                                                'assets/images/mohamed.jpeg')
                                            : NetworkImage(
                                                controller.userModel.pic),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: controller.userModel.name,
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                                CustomText(
                                  text: controller.userModel.email,
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: ListTile(
                            title: CustomText(
                              text: 'Edite Profile',
                            ),
                            leading:
                                Image.asset('assets/menu_icon/edit_icon.jpg'),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: ListTile(
                            title: CustomText(
                              text: 'Shipping Address',
                            ),
                            leading: Image.asset('assets/menu_icon/adress.png'),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: ListTile(
                            title: CustomText(
                              text: 'Order History',
                            ),
                            leading: Image.asset('assets/menu_icon/clock.png'),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: ListTile(
                            title: CustomText(
                              text: 'Cards',
                            ),
                            leading: Image.asset('assets/menu_icon/cards.png'),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: ListTile(
                            title: CustomText(
                              text: 'Notifications',
                            ),
                            leading: Image.asset(
                                'assets/menu_icon/notification.png'),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            controller.signOut();
                            Get.offAll(LoginScreen());
                          },
                          child: ListTile(
                            title: CustomText(
                              text: 'Log Out',
                            ),
                            leading: Image.asset('assets/menu_icon/logout.jpg'),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
    );
  }
}
