import 'package:my_workspace/untils/export_file.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:my_workspace/untils/export_file.dart';

class HotLeads extends StatefulWidget {
  const HotLeads({super.key});

  @override
  State<HotLeads> createState() => _HotLeadsState();
}

class _HotLeadsState extends State<HotLeads> {
  DashboardController dashboardcontroller = Get.put(DashboardController());
  // AuthController authcontroller = Get.put(AuthController());

//
  // MultPostingsController multiPostcontroller =
  //     Get.put(MultPostingsController());

  bool value = false;
  @override
  void initState() {
    // setState(() {
    //   / multiPostcontroller.multipostPagenumber.value = "1";
    // });
    dashboardcontroller.getHotLeads();

    super.initState();
  }

  //
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
            return Container(
                //  padding: EdgeInsets.all(10),
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
                                      dashboardcontroller
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
                                      dashboardcontroller
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
                              dashboardcontroller
                                          .choosenLeadDataByclent["leadType"] ==
                                      "hotlead"
                                  ? "assets/images/fire.png"
                                  : dashboardcontroller.choosenLeadDataByclent[
                                              "leadType"] ==
                                          "coldlead"
                                      ? "assets/images/ice.png"
                                      : "assets/images/ictempe.png",
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
                              dashboardcontroller.choosenLeadDataByclent[
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
                                  dashboardcontroller.choosenLeadDataByclent[
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
                                    text: dashboardcontroller
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
                                    dashboardcontroller
                                            .choosenLeadDataByclent["mailId"] ??
                                        "",
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
                                    text: dashboardcontroller
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
                                  color: Kwhite,
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW600),
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                //"bjljhvdbgkjsvfbnj;knkll                       mksdnkjlenjnkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj;;;;;n;  jk kj; ;kj n n lkj; k bl ;kjn vbbjh nnn bbkhljnn n bn mn n   njioioppppppppppppppppppppppppppppp",
                                dashboardcontroller
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

//
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
            "Hot Leads",
            // serviceData["tile"] + " issues",
            style: GoogleFonts.dmSans(
                color: Kwhite, fontSize: 20.sp, fontWeight: kFW600),
          )),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(16.r),
            child: Obx(
              () => Column(
                children: [
                  //["leadFor"]
                  SizedBox(height: 5.h),
                  CustomFormFields(
                    ontap: () {},
                    enabled: true,
                    labelColor: KText,
                    obscureText: false,
                    suffix: Icon(
                      Icons.search,
                      color: kblack,
                      size: 25.sp,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    fontSize: kFourteenFont,
                    fontWeight: FontWeight.w500,
                    hintText: "Search..",
                    maxLines: 1,
                    readOnly: false,
                    label: "",
                    validator: (value) {},
                    onChanged: (value) {
                      setState(() {
                        //                                   apiController.assetsData = apiController.OriginalassetsData;
                        // apiController.assetsData = apiController.assetsDatafilter;
                        dashboardcontroller.clienthotleads.value =
                            dashboardcontroller.filterclienthotleads
                                .where((element) => element["leadFor"]
                                    //
                                    // .where((element) => element["message"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toString().toLowerCase()))
                                .toList();
                      });
                      if (value == "") {
                        //  apiController.getRceiversLocationforBank();
                        setState(() {
                          dashboardcontroller.clienthotleads.value =
                              dashboardcontroller.originalclienthotleads;
                        });
                      }
                      if (dashboardcontroller.clienthotleads.isEmpty &&
                          value != "") {
                        Fluttertoast.showToast(
                          msg: "No Leads Available ,Search Again",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: KDarkPink_twg,
                          textColor: Kwhite,
                          fontSize: 16.0,
                        );

                        setState(() {
                          dashboardcontroller.getHotLeads();
                        });
                      }
                    },
                    // onChanged: ,
                  ),
                  SizedBox(height: 25.h),
                  dashboardcontroller.hotleadsLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Kform_border_twg,
                          ),
                        )
                      : dashboardcontroller.clienthotleads.isEmpty ||
                              dashboardcontroller.clienthotleads == null
                          ? Text(
                              "No Leads",
                              style: GoogleFonts.poppins(
                                  fontSize: kSixteenFont,
                                  color: KdarkText,
                                  fontWeight: kFW500),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  dashboardcontroller.clienthotleads.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      dashboardcontroller
                                              .choosenLeadDataByclent.value =
                                          dashboardcontroller
                                              .clienthotleads[index];
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
                                                  dashboardcontroller
                                                              .clienthotleads[
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
                                                  dashboardcontroller
                                                                  .clienthotleads[
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
                                              dashboardcontroller
                                                              .clienthotleads[
                                                          index]["leadType"] ==
                                                      "hotlead"
                                                  ? "assets/images/fire.png"
                                                  : dashboardcontroller
                                                                  .clienthotleads[
                                                              index]["leadType"] ==
                                                          "coldlead"
                                                      ? "assets/images/ice.png"
                                                      : "assets/images/ictempe.png",
                                              width: 30.w,
                                              height: 30.h,
                                            ),
                                            Text(
                                              dashboardcontroller
                                                          .clienthotleads[index]
                                                      ["leadType"] ??
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
                  // ListView.builder(
                  //     padding: EdgeInsets.zero,
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: dashboardcontroller.clienthotleads.length,
                  //     itemBuilder: (context, index) {
                  //       // var post =
                  //       //     multiPostcontroller
                  //       //             .mutiPostList[
                  //       //         index];
                  //       // String postId =
                  //       //     post['post_id'];
                  //       // var post =
                  //       //     multiPostcontroller.mutiPostList[index];

                  //       return Text("data");
                  //     })
                ],
              ),
            )),
      ),
    );

    ///////////////
  }
}
