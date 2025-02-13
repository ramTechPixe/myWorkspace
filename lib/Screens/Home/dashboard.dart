import 'package:flutter/services.dart';
import 'package:my_workspace/untils/export_file.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _formKey = GlobalKey<FormState>();
  DashboardController dashboardController = Get.put(DashboardController());
  String? selectedOption;
  bool passwordVisible = true;
  bool confirmpasswordVisible = true;
  //
  List toolsList = [
    {
      "tile": "Calendar ",
      "image": "assets/images/cut_calender.png",
      "subTitle": "To check the leads",
      "route": kCreateLead
    },
    {
      "tile": "All Leads",
      "image": "assets/images/cut_bulb.png",
      "subTitle": "Update Your Lead",
      "route": kClientAllLeads
    },
    {
      "tile": "Your Hot Leads",
      "image": "assets/images/cut_fire.png",
      "subTitle": "check your hot leads",
      "route": kHotLead
    },
    {
      "tile": "Entries",
      "image": "assets/images/cut_medal.png",
      "subTitle": "Create your lead",
      "route": kCreateLead
    },
  ];

  @override
  void initState() {
    dashboardController.getAllBusiness();
    dashboardController.getAllcalenderLeads();
    super.initState();
  }

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

  // calender
  String _getMonthName(int month) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  ///
  //
//////
  void _showCalendarPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select a Date",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) => false,
                  onDaySelected: (selectedDay, focusedDay) {
                    DateTime normalizedDate = DateTime(
                        selectedDay.year, selectedDay.month, selectedDay.day);

                    String formattedDate =
                        "${normalizedDate.year}-${normalizedDate.month.toString().padLeft(2, '0')}-${normalizedDate.day.toString().padLeft(2, '0')}";

                    if (dashboardController.eventData
                        .containsKey(normalizedDate)) {}
                    setState(() {
                      dashboardController.choosenLeadDateByclent.value =
                          "$formattedDate";
                    });

                    Navigator.pop(context);
                    Get.toNamed(kDayLeads);
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      DateTime normalizedDay =
                          DateTime(day.year, day.month, day.day);

                      if (dashboardController.eventData
                          .containsKey(normalizedDay)) {
                        return Container(
                          height: 40.h,
                          width: 40.w,
                          margin: EdgeInsets.only(bottom: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  '  ${day.day}', // Show date number
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '   ${dashboardController.eventData[normalizedDay]}', // Show count value
                                style: TextStyle(
                                    color: kblack,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the calendar pop-up
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ////

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          shadowColor: kblack,
          backgroundColor: Kwhite,
          automaticallyImplyLeading: false,
          titleSpacing: 20.w,
          title: SizedBox(
            width: 250.w,
            child: Text(
              "Hi! ${UserSimplePreferences.getClientName()}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.bungee(
                  color: kblack, fontSize: 20.sp, fontWeight: kFW600),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Are You Sure',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: kFW700,
                                color: KdarkText)),
                        content: Text('You Want To LogOut ?',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: kFW700,
                                color: KdarkText.withOpacity(0.7))),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('No',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText)),
                          ),
                          TextButton(
                            onPressed: () async {
                              // AuthController authController =
                              //     Get.put(AuthController());

                              // authcontroller
                              UserSimplePreferences.clearAllData();
                              Get.toNamed(kSignin);
                              // authcontroller.
                            },
                            child: Text('Yes',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText)),
                          )
                        ],
                      );
                    });
              },
              child: Icon(
                Icons.logout_sharp,
                color: kmwsBlueTheme,
                size: 24.sp,
              ),
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        backgroundColor: Kwhite,
        body: SingleChildScrollView(
            child: Obx(
          () => dashboardController.allBusinesLoading == true ||
                  dashboardController.calenderLeadsLoading == true
              ? Container(
                  margin: EdgeInsets.only(top: 300.h),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kmwsBlueTheme,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Workspace",
                        style: GoogleFonts.dmSans(
                            // style: GoogleFonts.silkscreen(
                            color: kmwsBlueTheme,
                            fontSize: 25.sp,
                            fontWeight: kFW600),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: toolsList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (toolsList[index]["tile"] == "Calendar ") {
                                  _showCalendarPopup(context);
                                } else {
                                  Get.toNamed(toolsList[index]["route"]);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                decoration: BoxDecoration(
                                    color: kmwsBlueTheme,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kblack.withOpacity(0.3),
                                        blurRadius: 1.r,
                                        offset: Offset(1, 1),
                                        spreadRadius: 2.r,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: Text(
                                              toolsList[index]["tile"],

                                              //   "Calendar ",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.dmSans(
                                                  // style: GoogleFonts.silkscreen(
                                                  color: Kwhite,
                                                  fontSize: 24.sp,
                                                  fontWeight: kFW600),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150.w,
                                            child: Text(
                                              toolsList[index]["subTitle"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //
                                              style: GoogleFonts.dmSans(
                                                  // style: GoogleFonts.silkscreen(
                                                  color: Kwhite,
                                                  fontSize: kTwelveFont,
                                                  fontWeight: kFW400),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 120.h,
                                      color: Kwhite,
                                      child: Image.asset(
                                        toolsList[index]["image"],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 130.h,
                      ),
                    ],
                  ),
                ),
        )),
      ),
    );
  }
}
