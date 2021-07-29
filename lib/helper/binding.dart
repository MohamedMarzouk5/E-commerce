import 'package:ecommerce/core/view_model/auth_view_model.dart';
import 'package:ecommerce/core/view_model/cart_viewmodel.dart';
import 'package:ecommerce/core/view_model/checkout_viewmodel.dart';
import 'package:ecommerce/core/view_model/control_view_model.dart';
import 'package:ecommerce/core/view_model/home_view_model.dart';
import 'package:ecommerce/helper/local_store_data.dart';
import 'package:get/get.dart';

//بنحط الكلاس اللي مسختدم فيها ال
//getcontroller
class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => CheckoutViewModel());
  }
}
