import 'package:ecommerce/constant.dart';
import 'package:ecommerce/core/view_model/auth_view_model.dart';
import 'package:ecommerce/view/auth/register_view.dart';
import 'package:ecommerce/view/widget/custom_button.dart';
import 'package:ecommerce/view/widget/custom_button_social.dart';
import 'package:ecommerce/view/widget/custom_text.dart';
import 'package:ecommerce/view/widget/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Welcome',
                      fontSize: 30,
                    ),
                    //ده تكست لما ادوس عليها يعمل حاجه
                    GestureDetector(
                      child: CustomText(
                        text: 'Sign Up',
                        fontSize: 18,
                        color: PrimaryColor,
                      ),
                      onTap: () {
                        Get.to(RegisterView());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Sign in to continue',
                  fontSize: 14,
                  color: Colors.grey,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: 'Email',
                  hint: 'Email',
                  onSave: (value) {
                    controller.email = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      print("Error");
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  text: 'Password',
                  hint: '*************',
                  onSave: (value) {
                    controller.password = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      print("Error");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'ForgotPassword?',
                  alignment: Alignment.topRight,
                  fontSize: 14,
                ),
                SizedBox(
                  height: 18,
                ),
                CustomButten(
                  text: 'SiGN IN',
                  onPressed: () {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      controller.signInWithEmailAndPassword();
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: '-OR-',
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButtenSocial(
                  text: 'Sign In with Facebook',
                  imageName: 'assets/images/facebook.png',
                  onPressed: () {
                    controller.facebookSignInMethod();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButtenSocial(
                  text: 'Sign In with Google',
                  imageName: 'assets/images/google.png',
                  onPressed: () {
                    controller.googleSignInMethod();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
