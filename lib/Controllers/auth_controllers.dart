import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_workspace/untils/export_file.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:io';

class AuthController extends GetxController {
  final apiService = Get.put(ApiService());
  //ProfileController userprofilecontroller = Get.put(ProfileController());

  ////////////////////////////////////////////////
  var counter = 0.obs;
  late TextEditingController textController;
  late TextEditingController numberOfWordsController;
  @override
  void onInit() {
    super.onInit();

    // Initialize the TextEditingController
    textController = TextEditingController(text: counter.value.toString());
    numberOfWordsController =
        TextEditingController(text: counter.value.toString());
    // Update the text field whenever the counter changes
    counter.listen((value) {
      textController.text = value.toString();
      numberOfWordsController.text = value.toString();
    });
    // _razorpay = Razorpay();

    // // Set up event listeners
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void increment() {
    counter.value++;
  }

  void decrement() {
    if (counter.value > 0) {
      counter.value--;
    }
  }

  void setCounter(String value) {
    final int? parsedValue = int.tryParse(value);
    if (parsedValue != null && parsedValue >= 0) {
      counter.value = parsedValue;
    }
  }
  ///////////////////////////////////////////////////////

  TextEditingController UserEmailSignInController = TextEditingController();
  TextEditingController UserEmailPasswordController = TextEditingController();

  //
  TextEditingController autoPostMessageController = TextEditingController();
  TextEditingController autoPostHeadingController = TextEditingController();
  TextEditingController aiMessageLinkController = TextEditingController();
  TextEditingController signUpCouponController = TextEditingController();
  ////////Coupons Api
  var signUpCouponLoading = false.obs;
  var isCouponApplied = false.obs;
  var signUpCoupondata = {}.obs;

  ////////

  var userSignInLoading = false.obs;
  Future<void> userSignIn(Map payload) async {
    userSignInLoading(true);

    try {
      //
      var response = await apiService.postRequestNotoken(
          endpoint: "clients/login", payload: payload);
//http://192.168.1.25:8085/api/clients/login
      //    Map data = jsonDecode(response);
      Map data = response;
      print(data);
      if (data["status"] == "OK") {
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        await UserSimplePreferences.setToken(
            token: data["jwtToken"].toString());

        // id name role
        await UserSimplePreferences.setClientName(
            name: data["fullName"].toString());
        await UserSimplePreferences.setClientId(id: data["id"].toString());
        await UserSimplePreferences.setRole(userRole: data["role"].toString());
        Fluttertoast.showToast(
          msg: "Login Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kmwsBlueTheme,
          textColor: Kwhite,
          fontSize: 16.0,
        );
        //   userprofilecontroller.userProfileNavigation();
        Get.toNamed(kDashboard);

        print("object");
      } else if (data["status"] == 500) {
        Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: KDarkPink_twg,
          textColor: Kwhite,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: KDarkPink_twg,
          textColor: Kwhite,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: KDarkPink_twg,
        textColor: Kwhite,
        fontSize: 16.0,
      );
    } finally {
      userSignInLoading(false);
    }
  }

  //
}
