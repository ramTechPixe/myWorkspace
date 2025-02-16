import 'package:flutter/material.dart';
import 'package:my_workspace/untils/constants.dart';
import 'package:my_workspace/untils/export_file.dart';
import 'package:my_workspace/untils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //////////////////////////////////////////
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: "My Work Space",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'DMSans',
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent),
            ),
            getPages: Routes.routes,
            initialRoute:
                // ktest,
                //kDayLeads,
                // kOnboarding,
                kSplash,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!);
            });
      },
    );
    ///////////////////////////////////////////////////////
  }
}
