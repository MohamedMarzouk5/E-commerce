import 'package:ecommerce/constant.dart';
import 'package:ecommerce/core/view_model/cart_viewmodel.dart';
import 'package:ecommerce/view/checkout.dart/checkout_view.dart';
import 'package:ecommerce/view/widget/custom_button.dart';
import 'package:ecommerce/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartView extends StatelessWidget {
  List<String> names = <String>[
    'mohamed',
    'marzouk',
    'abas',
    'marzouk',
    'marzouk'
  ];
  List<String> images = <String>[
    'assets/images/chaire.png',
    'assets/images/chaire.png',
    'assets/images/chaire.png',
    'assets/images/chaire.png',
    'assets/images/chaire.png'
  ];
  List<int> price = <int>[
    100,
    200,
    300,
    400,
    500,
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
        init: Get.put(CartViewModel()),
        builder: (controller) => Scaffold(
              body: controller.cartProductModel.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/cart_empty.svg',
                            width: 200, height: 200),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: 'Cart Empty',
                          fontSize: 32,
                          alignment: Alignment.topCenter,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                    height: 140,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Image.network(
                                            controller
                                                .cartProductModel[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: controller
                                                    .cartProductModel[index]
                                                    .name,
                                                fontSize: 20,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomText(
                                                color: PrimaryColor,
                                                text:
                                                    ' \ ${'\$' + controller.cartProductModel[index].price.toString()}',
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: 140,
                                                color: Colors.grey.shade200,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .increaseQuantity(
                                                                index);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    CustomText(
                                                      alignment:
                                                          Alignment.center,
                                                      text: controller
                                                          .cartProductModel[
                                                              index]
                                                          .quantity
                                                          .toString(),
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .decreaseQuantity(
                                                                index);
                                                      },
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: Icon(
                                                            Icons.minimize,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                              itemCount: controller.cartProductModel.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 15,
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    text: 'TOTAL',
                                    fontSize: 22,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GetBuilder<CartViewModel>(
                                    init: Get.find(),
                                    builder: (controller) => CustomText(
                                      text: '\$ + ${controller.totalPrice}',
                                      fontSize: 18,
                                      color: PrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: 180,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CustomButten(
                                    onPressed: () {
                                      Get.to(CheckoutView());
                                    },
                                    text: 'CHECKOUT',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ));
  }
}
