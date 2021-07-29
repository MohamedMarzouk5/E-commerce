import 'package:ecommerce/core/services/firestore_user.dart';
import 'package:ecommerce/helper/local_store_data.dart';
import 'package:ecommerce/model/user_model.dart';
import 'package:ecommerce/view/control_view.dart';
import 'package:ecommerce/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

//بربط بين ال view و ال  model
class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  String email, password, name;
  final LocalStorageData localStorageData = Get.find();
//ده علشان لما اعمل log in rmail and pass
//ميرجعش ل صفحه الدخول يدخل في الهوم اسكرين علي طول
//rx علشان ال getx
  Rx<User> _user = Rx<User>();

  String get user => _user.value?.email;

  @override
  void onInit() {
    //دي لما بستدعي ال كنترولر يعمل حاجه معينه زي يجيب الداتا من النت
    // TODO: implement onInit
    super.onInit();
    //علشان لو حصل اي تغير في الايميل
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUserData(_auth.currentUser.uid);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // print(googleUser);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
//علشان في ال فاير بيز يعمل authentication
    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user);
      // Get.offAll(HomeScreen());
      Get.offAll(ControlView());
    });
  }

  void facebookSignInMethod() async {
    // final AccessToken result = await FacebookAuth.instance.login();

    FacebookLoginResult result = await _facebookLogin.logIn(['email']);
    final accessToken = result.accessToken.token;
    if (result.status == FacebookLoginStatus.loggedIn) {
      final faceCredential = FacebookAuthProvider.credential(accessToken);
      await _auth.signInWithCredential(faceCredential).then((user) async {
        saveUser(user);
      });
      Get.to(HomeScreen());
    }

    // final FacebookAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(result.token);

    // await _auth.signInWithCredential(facebookAuthCredential).then((user) {
    //   saveUser(user);
    // }
    // );
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        getCurrentUserData(value.user.uid);
      });
      Get.offAll(ControlView());
    } catch (e) {
      print(e.message);
      Get.snackbar(
        'Error login account',
        e.message,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createAccountWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(ControlView());
    } catch (e) {
      print(e.message);
      Get.snackbar(
        'Error login account',
        e.message,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      userId: user.user.uid,
      email: user.user.email,

      //الاسم اللي موجود في ال facebook or google
      //لو مكتبتش الاسم
      name: name == null ? user.user.displayName : name,
      pic: 'default',
    );
    await FireStoreUser().addUserToFireStore(userModel);
    await setUser(userModel);
  }

//عملنا الميثود دي علشان لما الداتا لما تيجي من الفاير بيز نحطها في ال شيرد بيرفرنس علشان لو مسحنا التطبيق ورجعناه تاني يجيب البيانات
  void getCurrentUserData(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) {
      setUser(UserModel.fromJson(value.data()));
    });
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
  }
}
