// import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:my_workspace/untils/export_file.dart';

class Routes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: kSplash,
        transition: Transition.rightToLeft,
        page: () => const SplashScreen()),
    GetPage(
        name: kSignin,
        transition: Transition.rightToLeft,
        page: () => const SignIn()),
    GetPage(
        name: kDashboard,
        transition: Transition.rightToLeft,
        page: () => const Dashboard()),
    GetPage(
        name: kCreateLead,
        transition: Transition.rightToLeft,
        page: () => const Create_lead()),
    GetPage(
        name: kHotLead,
        transition: Transition.rightToLeft,
        page: () => const HotLeads()),
    GetPage(
        name: kClientAllLeads,
        transition: Transition.rightToLeft,
        page: () => const All_leads()),
    GetPage(
        name: kUpdateLeads,
        transition: Transition.rightToLeft,
        page: () => const Update_lead()),
    GetPage(
        name: kDayLeads,
        transition: Transition.rightToLeft,
        page: () => const DayLeads()),
    GetPage(
        name: ktest,
        transition: Transition.rightToLeft,
        page: () => const KtestScreen()),
    //
  ];
}
