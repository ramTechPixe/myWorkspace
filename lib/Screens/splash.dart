import 'package:my_workspace/untils/export_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//  ProfileController userprofilecontroller = Get.put(ProfileController());
  /////////////////////////////////////////////
  bool? isUserLoggedIn;
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () async {
    //   Get.toNamed(kSignin);
    // });
    //////////////////////////////
    isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    Future.delayed(const Duration(seconds: 2), () async {
      if (isUserLoggedIn != null && isUserLoggedIn == true) {
        // Get.toNamed(kNavigation);
        Get.toNamed(kDashboard);
      } else {
        Get.toNamed(kSignin);
        // Get.toNamed(kOnboarding);
      }
    });
    /////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [KGradientPurple_twg, KGradientPink_twg, KLightPurple_twg],
            //     begin: Alignment.topRight,
            //     end: Alignment.bottomLeft,
            //   ),
            // ),

            child: Image.asset(
              "assets/images/workspace_splash.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //   fit: BoxFit.fitHeight,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/workspace_logo2.png",
                  height: 100.h,
                  width: 100.w,
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "My Workspace",
                  style: GoogleFonts.rubikMicrobe(
                      // style: GoogleFonts.silkscreen(
                      color: KOrange,
                      fontSize: 32.sp,
                      fontWeight: kFW600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
