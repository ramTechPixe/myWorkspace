import 'package:flutter/services.dart';
import 'package:my_workspace/untils/export_file.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthController authcontroller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  String? selectedOption;
  bool passwordVisible = true;
  bool confirmpasswordVisible = true;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            content: Text(
              'Do you want to exit this App',
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Kblue_twg),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    setState(() {
      authcontroller.UserEmailSignInController.text = "dharanisri564@gmail.com";

      authcontroller.UserEmailPasswordController.text = "AZSZ2788";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Kwhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    "My Workspace",
                    style: GoogleFonts.rubikMicrobe(
                        // style: GoogleFonts.silkscreen(
                        color: kmwsBlueTheme,
                        fontSize: 25.sp,
                        fontWeight: kFW600),
                  ),
                  Container(
                    height: 200.h,
                    child: Image.asset(
                      "assets/images/blue_stone_two.png",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 130.h,
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: GoogleFonts.dmSans(
                            // style: GoogleFonts.silkscreen(
                            color: kblack,
                            fontSize: 28.sp,
                            fontWeight: kFW600),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        "Access your account securely.",
                        style: GoogleFonts.dmSans(
                            // style: GoogleFonts.silkscreen(
                            color: kblack,
                            fontSize: kFourteenFont,
                            fontWeight: kFW400),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomFormFields(
                        ontap: () {
                          //  Get.toNamed(kSearchPlaces); // kForgotPassword
                        },
                        controller: authcontroller.UserEmailSignInController,
                        enabled: true,
                        labelColor: KText,
                        obscureText: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        fontSize: kFourteenFont,
                        fontWeight: FontWeight.w500,
                        hintText: "Email",
                        maxLines: 1,
                        readOnly: false,
                        label: "Email",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Password",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontSize: kSixteenFont,
                            //  letterSpacing: 1,
                            color: KBlack_twg,
                            fontWeight: kFW400),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Kwhite,
                        ),
                        child: TextFormField(
                          cursorColor: kmwsBlueTheme,
                          obscureText: passwordVisible,
                          obscuringCharacter: '*',
                          enabled: true,
                          readOnly: false,
                          controller:
                              authcontroller.UserEmailPasswordController,
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: kFW500,
                              color: kblack),
                          decoration: InputDecoration(
                            focusColor: Kwhite,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: KText_border_twg, width: 0.5),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: KRed_twg, width: 0.5),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: KText_border_twg, width: 0.5),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kmwsBlueTheme, width: 1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kmwsBlueTheme, width: 1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            fillColor: Kwhite,

                            hintText: "Enter Password",
                            alignLabelWithHint: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20.sp,
                                color: kmwsBlueTheme,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            //make hint text
                            hintStyle: GoogleFonts.poppins(
                              color: KLighText_twg,
                              fontSize: 14.sp,
                              fontWeight: kFW400,
                            ),
                            //////////////////

                            ////////////

                            //create lable
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      //////////////
                      Obx(
                        () => authcontroller.userSignInLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Kform_border_twg,
                                ),
                              )
                            : CustomButton(
                                margin: EdgeInsets.only(top: 36.h),
                                borderRadius: BorderRadius.circular(8.r),
                                Color: kmwsBlueTheme,
                                textColor: Kwhite,
                                height: 40,
                                width: double.infinity,
                                label: "Sign In",
                                fontSize: kSixteenFont,
                                fontWeight: kFW700,
                                isLoading: false,
                                onTap: () {
                                  var payload = {
                                    "username": authcontroller
                                        .UserEmailSignInController.text,
                                    "password": authcontroller
                                        .UserEmailPasswordController.text
                                  };

                                  // if (_formKey.currentState!.validate()) {
                                  //   authcontroller.userSignIn(payload);
                                  // }
                                  if (_formKey.currentState!.validate()) {
                                    authcontroller.userSignIn(payload);
                                  }
                                  // Get.toNamed(kNavigation);
                                }),
                      ),
                      // CustomButton(
                      //     margin: EdgeInsets.only(top: 36.h),
                      //     borderRadius: BorderRadius.circular(8.r),
                      //     Color: kmwsBlueTheme,
                      //     textColor: Kwhite,
                      //     height: 40,
                      //     width: double.infinity,
                      //     label: "Sign In",
                      //     fontSize: kSixteenFont,
                      //     fontWeight: kFW700,
                      //     isLoading: false,
                      //     onTap: () {
                      //       // var payload = {
                      //       //   "user_email": authcontroller
                      //       //       .UserEmailSignInController.text,
                      //       //   "user_password": authcontroller
                      //       //       .UserEmailPasswordController.text
                      //       // };

                      //       // if (_formKey.currentState!.validate()) {
                      //       //   // authcontroller.userSignIn(payload);
                      //       // }
                      //       Get.toNamed(kDashboard);
                      //     }),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
