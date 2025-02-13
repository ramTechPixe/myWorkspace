import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_workspace/untils/export_file.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

class DayLeads extends StatefulWidget {
  const DayLeads({super.key});

  @override
  State<DayLeads> createState() => _DayLeadsState();
}

class _DayLeadsState extends State<DayLeads> {
  DashboardController dashboardController = Get.put(DashboardController());
  String? selectedUserValue;
  String? selectedValue;
  String? selectedGenderValue;
  DateTime selectedDate = DateTime.now();
  DateTime choosenDate = DateTime.now();
  var selectDate = "Select Date".obs;

  @override
  void initState() {
    dashboardController.getselectedDayList();
    // setState(() {
    //   authcontroller.UserEmailSignInController.text = "dharanisri564@gmail.com";

    //   authcontroller.UserEmailPasswordController.text = "AZSZ2788";
    // });

    super.initState();
  }

  ////
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

                    dashboardController.getselectedDayList();
                    Navigator.pop(context);
                    // Get.toNamed(kDayLeads);
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
                                  '  ${day.day}',  
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
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       insetPadding: EdgeInsets.all(10),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Container(
    //         padding: EdgeInsets.all(3),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(
    //               "Select a Date",
    //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //             ),
    //             SizedBox(height: 10),
    //             TableCalendar(
    //               firstDay: DateTime(2000),
    //               lastDay: DateTime(2100),
    //               focusedDay: DateTime.now(),
    //               calendarFormat: CalendarFormat.month,
    //               selectedDayPredicate: (day) =>
    //                   false, // No selection highlight

    //               onDaySelected: (selectedDay, focusedDay) {
    //                 DateTime normalizedDate = DateTime(
    //                     selectedDay.year, selectedDay.month, selectedDay.day);

    //                 String formattedDate =
    //                     "${normalizedDate.year}-${normalizedDate.month.toString().padLeft(2, '0')}-${normalizedDate.day.toString().padLeft(2, '0')}";

    //                 if (dashboardController.eventData
    //                     .containsKey(normalizedDate)) {

    //                 }
    //                 setState(() {
    //                   dashboardController.choosenLeadDateByclent.value =
    //                       "$formattedDate";
    //                 });

    //                 dashboardController.getselectedDayList();
    //                 Navigator.pop(context);
    //                 // Get.toNamed(kDayLeads);
    //               },

    //               calendarBuilders: CalendarBuilders(
    //                 defaultBuilder: (context, day, focusedDay) {
    //                   DateTime normalizedDay =
    //                       DateTime(day.year, day.month, day.day);

    //                   // ✅ Check if this day has an event
    //                   if (dashboardController.eventData
    //                       .containsKey(normalizedDay)) {
    //                     return Container(
    //                       margin: EdgeInsets.all(4),
    //                       decoration: BoxDecoration(
    //                         color: Colors.blue,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             '${day.day}', // Show date number
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                           Text(
    //                             '${dashboardController.eventData[normalizedDay]}', // Show count value
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 12,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   }
    //                   return null;
    //                 },
    //               ),
    //             ),
    //             SizedBox(height: 10),
    //             ElevatedButton(
    //               onPressed: () {
    //                 Navigator.pop(context); // Close the calendar pop-up
    //               },
    //               child: Text("Close"),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled:
          true, // Allows the height to be dynamic based on content
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0), // Top rounded corners
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            // You can now use setState here to update the bottom sheet content
            return Container(
                // padding: EdgeInsets.all(10),
                child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.2,
              // margin: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                  color: Kwhite,
                  //  border: Border.all(color: kmwsBlueTheme, width: 0.6),
                  boxShadow: [
                    BoxShadow(
                      color: kblack.withOpacity(0.3),
                      blurRadius: 1.r,
                      offset: Offset(1, 1),
                      spreadRadius: 2.r,
                    )
                  ],
                  borderRadius: BorderRadius.circular(
                      10.r)), // Adjust padding inside the bottom sheet
              child: Column(
                children: [
                  Container(
                    //  height: MediaQuery.of(context).size.height / ,
                    // height: MediaQuery.of(context).size.height / 8,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                        color: kmwsBlueTheme,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Kwhite,
                                  child: Image.asset(
                                    "assets/images/astroLogo.png",
                                    width: 70.w,
                                    height: 70.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dashboardController
                                                  .choosenLeadDataByclent[
                                              "leadFor"] ??
                                          "",
                                      //   "Astro card",
                                      style: GoogleFonts.poppins(
                                          // style: GoogleFonts.silkscreen(
                                          color: Kwhite,
                                          fontSize: kTwentyFont,
                                          fontWeight: kFW700),
                                    ),
                                    Text(
                                      dashboardController
                                                  .choosenLeadDataByclent[
                                              "bussinessName"] ??
                                          "",
                                      style: GoogleFonts.poppins(
                                          color: Kwhite,
                                          fontSize: kFourteenFont,
                                          fontWeight: kFW400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.asset(
                              dashboardController
                                          .choosenLeadDataByclent["leadType"] ==
                                      "hotlead"
                                  ? "assets/images/fire.png"
                                  : dashboardController.choosenLeadDataByclent[
                                              "leadType"] ==
                                          "coldlead"
                                      ? "assets/images/ice.png"
                                      : "assets/images/temp.png",
                              width: 30.w,
                              height: 30.h,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Business type : ",
                              style: GoogleFonts.poppins(
                                  // style: GoogleFonts.silkscreen(
                                  color: Kwhite,
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW600),
                            ),
                            Text(
                              dashboardController.choosenLeadDataByclent[
                                      "bussinessType"] ??
                                  "",
                              //   "Astro card",
                              style: GoogleFonts.poppins(
                                  // style: GoogleFonts.silkscreen(
                                  color: Kwhite,
                                  fontSize: kSixteenFont,
                                  fontWeight: kFW600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Mobile : ",
                                  style: GoogleFonts.poppins(
                                      // style: GoogleFonts.silkscreen(
                                      color: Kwhite,
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW600),
                                ),
                                Text(
                                  dashboardController.choosenLeadDataByclent[
                                              "mobileNumber"]
                                          .toString() ??
                                      "",
                                  //   "Astro card",
                                  style: GoogleFonts.poppins(
                                      // style: GoogleFonts.silkscreen(
                                      color: Kwhite,
                                      fontSize: kSixteenFont,
                                      fontWeight: kFW600),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: dashboardController
                                            .choosenLeadDataByclent[
                                                "mobileNumber"]
                                            .toString() ??
                                        ""));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Text copied to clipboard")),
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                color: Kwhite,
                                size: 20.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Email : ",
                                  style: GoogleFonts.poppins(
                                      // style: GoogleFonts.silkscreen(
                                      color: Kwhite,
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW600),
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    dashboardController
                                            .choosenLeadDataByclent["mailId"] ??
                                        "",
                                    //   "Astro card",
                                    overflow: TextOverflow.ellipsis,
                                    //   "Astro card",
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                        // style: GoogleFonts.silkscreen(
                                        color: Kwhite,
                                        fontSize: kSixteenFont,
                                        fontWeight: kFW600),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: dashboardController
                                            .choosenLeadDataByclent["mailId"] ??
                                        ""));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Text copied to clipboard")),
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                color: Kwhite,
                                size: 20.sp,
                              ),
                            )
                            //
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Address : ",
                              style: GoogleFonts.poppins(
                                  // style: GoogleFonts.silkscreen(
                                  color: Kwhite,
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW600),
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                //"bjljhvdbgkjsvfbnj;knkll                       mksdnkjlenjnkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj;;;;;n;  jk kj; ;kj n n lkj; k bl ;kjn vbbjh nnn bbkhljnn n bn mn n   njioioppppppppppppppppppppppppppppp",
                                dashboardController
                                        .choosenLeadDataByclent["address"] ??
                                    "",
                                //   "Astro card",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    // style: GoogleFonts.silkscreen(

                                    color: Kwhite,
                                    fontSize: kSixteenFont,
                                    fontWeight: kFW600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Text(
              //   "Show date numbe",
              //   style: TextStyle(
              //       color: kblack, fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // Column(
              //   mainAxisSize: MainAxisSize
              //       .min, // Ensures the bottom sheet adjusts to the content height
              //   children: [
              //     Text(
              //       'Feedback Form', // You can replace this with your own widget like Feedback_view()
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     SizedBox(height: 20),
              //     // Add your content/widgets here
              //     Container(
              //       height: 200, // Example size, replace with your actual content
              //       color: Colors.blue,
              //       child: Center(child: Text('Add your feedback form here')),
              //     ),
              //     SizedBox(height: 20),
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.pop(context); // Close the bottom sheet when pressed
              //       },
              //       child: Text('Close'),
              //     ),
              //   ],
              // ),
            ));
          },
        );
      },
    );
  }

  // Lead view

  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: AppBar(
            elevation: 3,
            shadowColor: kblack,
            backgroundColor: kmwsBlueTheme,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Kwhite,
                size: 23.sp,
              ),
            ),
            title: Text(
              "Leads in a Day",
              // serviceData["tile"] + " issues",
              style: GoogleFonts.dmSans(
                  color: Kwhite, fontSize: 20.sp, fontWeight: kFW600),
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Obx(
              () => dashboardController.selectedDayListLoading == true
                  ? Container(
                      margin: EdgeInsets.only(top: 300.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kmwsBlueTheme,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormFields(
                          hintText:
                              dashboardController.choosenLeadDateByclent.value,
                          // hintText: DateFormat('yyyy-MM-dd')
                          //             .format(selectedDate) ==
                          //         DateFormat('yyyy-MM-dd')
                          //             .format(DateTime.now())
                          //     ? "Select Date"
                          //     : DateFormat('yyyy-MM-dd').format(selectedDate),
                          ontap: () {
                            _showCalendarPopup(context);
                          },

                          enabled: true,
                          readOnly: true,
                          labelColor: KText,
                          onChanged: (value) {
                            setState(() {});
                          },
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          suffix: Padding(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.calendar_month),
                          ),
                          fontWeight: FontWeight.w500,
                          hintColor:
                              DateFormat('yyyy-MM-dd').format(selectedDate) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                  ? KTextgery.withOpacity(0.5)
                                  : KdarkText,
                          maxLines: 1,
                          label: "Select Lead Date",
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        dashboardController.selectedDayList.isEmpty ||
                                dashboardController.selectedDayList == null
                            ? Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/no_leads.png",
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                    ),
                                    Text(
                                      "No Leads for ${dashboardController.choosenLeadDateByclent}",
                                      //   "Astro card",
                                      style: GoogleFonts.poppins(
                                          // style: GoogleFonts.silkscreen(
                                          color: KdarkText,
                                          fontSize: kTwentyFont,
                                          fontWeight: kFW700),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    dashboardController.selectedDayList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        dashboardController
                                                .choosenLeadDataByclent.value =
                                            dashboardController
                                                .selectedDayList[index];
                                      });
                                      showCustomBottomSheet(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      decoration: BoxDecoration(
                                          color: kmwsBlueTheme,
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                color: Kwhite,
                                                child: Image.asset(
                                                  "assets/images/astroLogo.png",
                                                  width: 70.w,
                                                  height: 70.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dashboardController
                                                                .selectedDayList[
                                                            index]["leadFor"] ??
                                                        "",
                                                    //   "Astro card",
                                                    style: GoogleFonts.poppins(
                                                        // style: GoogleFonts.silkscreen(
                                                        color: Kwhite,
                                                        fontSize: kTwentyFont,
                                                        fontWeight: kFW700),
                                                  ),
                                                  Text(
                                                    dashboardController
                                                                    .selectedDayList[
                                                                index]
                                                            ["bussinessName"] ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        color: Kwhite,
                                                        fontSize: kFourteenFont,
                                                        fontWeight: kFW400),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                dashboardController.selectedDayList[
                                                                index]
                                                            ["leadType"] ==
                                                        "hotlead"
                                                    ? "assets/images/fire.png"
                                                    : dashboardController
                                                                        .selectedDayList[
                                                                    index]
                                                                ["leadType"] ==
                                                            "coldlead"
                                                        ? "assets/images/ice.png"
                                                        : "assets/images/temp.png",
                                                width: 30.w,
                                                height: 30.h,
                                              ),
                                              Text(
                                                dashboardController
                                                            .selectedDayList[
                                                        index]["leadType"] ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    color: Kwhite,
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                      ],
                    ),
            ),
          ),
        ));
  }
}
