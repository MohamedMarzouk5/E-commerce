import 'package:ecommerce/core/view_model/profile_view_model.dart';
import 'package:ecommerce/helper/binding.dart';
import 'package:ecommerce/view/control_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/view_model/cart_viewmodel.dart';

void main() async {
  //علشان تسجيل الدخول
  //واستخدام ال firbase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(CartViewModel());
  Get.put(ControlView());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SourceSans'),
      home: Scaffold(
        body: ControlView(),
      ),
    );
  }
}
