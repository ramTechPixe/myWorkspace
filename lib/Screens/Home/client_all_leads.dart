import 'package:my_workspace/untils/export_file.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:my_workspace/untils/export_file.dart';

class All_leads extends StatefulWidget {
  const All_leads({super.key});

  @override
  State<All_leads> createState() => _All_leadsState();
}

class _All_leadsState extends State<All_leads> {
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
    dashboardcontroller.getAllLeads();

    super.initState();
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
            return SingleChildScrollView(
              child: Container(
                  //  padding: EdgeInsets.all(10),
                  child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.5,
                // height: MediaQuery.of(context).size.height / 2.2,

                decoration: BoxDecoration(
                    color: Kwhite,
                    boxShadow: [
                      BoxShadow(
                        color: kblack.withOpacity(0.3),
                        blurRadius: 1.r,
                        offset: Offset(1, 1),
                        spreadRadius: 2.r,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                dashboardcontroller.choosenLeadDataByclent[
                                            "leadType"] ==
                                        "hotlead"
                                    ? "assets/images/fire.png"
                                    : dashboardcontroller
                                                    .choosenLeadDataByclent[
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
                            height: 12.h,
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
                                      dashboardcontroller
                                                  .choosenLeadDataByclent[
                                              "mailId"] ??
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
                                                  .choosenLeadDataByclent[
                                              "mailId"] ??
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
                                    // style: GoogleFonts.silkscreen(
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Update lead",
                      style: GoogleFonts.poppins(
                          // style: GoogleFonts.silkscreen(
                          color: kblack,
                          fontSize: kTwentyFont,
                          fontWeight: kFW700),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        var payload = {
                          "leadType": "hotlead",
                        };

                        //  if (selectedImage != null) {
                        dashboardcontroller.updateLeads(
                            payload,
                            dashboardcontroller.choosenLeadDataByclent["id"]
                                .toString());
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: dashboardcontroller.leadStatus.value == "hotlead"
                            ? Kblue_twg
                            : Kwhite,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/fire.png",
                              // dashboardcontroller
                              //             .choosenLeadDataByclent["leadType"] ==
                              //         "hotlead"
                              //     ?
                              //     : dashboardcontroller
                              //                 .choosenLeadDataByclent["leadType"] ==
                              //             "coldlead"
                              //         ? "assets/images/ice.png"
                              //         : "assets/images/ictempe.png",
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Hot Lead",
                              style: GoogleFonts.poppins(
                                  // style: GoogleFonts.silkscreen(
                                  color: dashboardcontroller.leadStatus.value ==
                                          "hotlead"
                                      ? Kwhite
                                      : kblack,
                                  fontSize: 17.sp,
                                  fontWeight: kFW600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    InkWell(
                      onTap: () {
                        var payload = {
                          "leadType": "coldlead",
                        };

                        //  if (selectedImage != null) {
                        dashboardcontroller.updateLeads(
                            payload,
                            dashboardcontroller.choosenLeadDataByclent["id"]
                                .toString());
                        Navigator.pop(context);
                      },
                      child: Container(
                        color:
                            dashboardcontroller.leadStatus.value == "coldlead"
                                ? Kblue_twg
                                : Kwhite,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ice.png",
                              // dashboardcontroller
                              //             .choosenLeadDataByclent["leadType"] ==
                              //         "hotlead"
                              //     ?
                              //     : dashboardcontroller
                              //                 .choosenLeadDataByclent["leadType"] ==
                              //             "coldlead"
                              //         ? "assets/images/ice.png"
                              //         : "assets/images/ictempe.png",
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Cold Lead",
                              style: GoogleFonts.poppins(
                                  // style: GoogleFonts.silkscreen(
                                  color: dashboardcontroller.leadStatus.value ==
                                          "coldlead"
                                      ? Kwhite
                                      : kblack,
                                  fontSize: 17.sp,
                                  fontWeight: kFW600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // warmlead
                    InkWell(
                      onTap: () {
                        var payload = {
                          "leadType": "warmlead",
                        };

                        //  if (selectedImage != null) {
                        dashboardcontroller.updateLeads(
                            payload,
                            dashboardcontroller.choosenLeadDataByclent["id"]
                                .toString());
                        Navigator.pop(context);
                      },
                      child: Container(
                        color:
                            dashboardcontroller.leadStatus.value == "warmlead"
                                ? Kblue_twg
                                : Kwhite,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/temp.png",
                              // dashboardcontroller
                              //             .choosenLeadDataByclent["leadType"] ==
                              //         "hotlead"
                              //     ?
                              //     : dashboardcontroller
                              //                 .choosenLeadDataByclent["leadType"] ==
                              //             "coldlead"
                              //         ? "assets/images/ice.png"
                              //         : "assets/images/ictempe.png",
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Warm Lead",
                              style: GoogleFonts.poppins(
                                  // style: GoogleFonts.silkscreen(
                                  color: dashboardcontroller.leadStatus.value ==
                                          "warmlead"
                                      ? Kwhite
                                      : kblack,
                                  fontSize: 17.sp,
                                  fontWeight: kFW600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      color: dashboardcontroller.leadStatus.value == "closelead"
                          ? Kblue_twg
                          : Kwhite,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/close.png",
                            // dashboardcontroller
                            //             .choosenLeadDataByclent["leadType"] ==
                            //         "hotlead"
                            //     ?
                            //     : dashboardcontroller
                            //                 .choosenLeadDataByclent["leadType"] ==
                            //             "coldlead"
                            //         ? "assets/images/ice.png"
                            //         : "assets/images/ictempe.png",
                            width: 30.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "Close Lead",
                            style: GoogleFonts.poppins(
                                // style: GoogleFonts.silkscreen(
                                color: dashboardcontroller.leadStatus.value ==
                                        "closelead"
                                    ? Kwhite
                                    : kblack,
                                fontSize: 17.sp,
                                fontWeight: kFW600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            );
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
            "All Leads",
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
                        dashboardcontroller.alleads.value =
                            dashboardcontroller.filteralleads
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
                          dashboardcontroller.alleads.value =
                              dashboardcontroller.originalalleads;
                        });
                      }
                      if (dashboardcontroller.alleads.isEmpty && value != "") {
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
                          dashboardcontroller.getAllLeads();
                        });
                      }
                    },
                    // onChanged: ,
                  ),
                  SizedBox(height: 25.h),
                  dashboardcontroller.allleadsLoading == true ||
                          dashboardcontroller.updateLeadLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Kform_border_twg,
                          ),
                        )
                      : dashboardcontroller.alleads.isEmpty ||
                              dashboardcontroller.alleads == null
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
                              itemCount: dashboardcontroller.alleads.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      // leadStatus
                                      dashboardcontroller.leadStatus.value =
                                          dashboardcontroller.alleads[index]
                                              ["leadType"];
                                      dashboardcontroller
                                              .choosenLeadDataByclent.value =
                                          dashboardcontroller.alleads[index];
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
                                                              .alleads[index]
                                                          ["leadFor"] ??
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
                                                              .alleads[index]
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
                                              dashboardcontroller.alleads[index]
                                                          ["leadType"] ==
                                                      "hotlead"
                                                  ? "assets/images/fire.png"
                                                  : dashboardcontroller.alleads[
                                                                  index]
                                                              ["leadType"] ==
                                                          "coldlead"
                                                      ? "assets/images/ice.png"
                                                      : "assets/images/temp.png",
                                              width: 30.w,
                                              height: 30.h,
                                            ),
                                            Text(
                                              dashboardcontroller.alleads[index]
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
                  //  ListView.builder(
                  //     padding: EdgeInsets.zero,
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: dashboardcontroller.alleads.length,
                  //     itemBuilder: (context, index) {

                  //       return InkWell(
                  //         onTap: () {
                  //           dashboardcontroller.getLeadsID(dashboardcontroller
                  //               .alleads[index]["id"]
                  //               .toString());
                  //         },
                  //         child: Container(
                  //           margin: EdgeInsets.all(10),
                  //           child: Column(
                  //             children: [
                  //               Text(dashboardcontroller.alleads[index]
                  //                   ["leadType"]),
                  //               Text(dashboardcontroller.alleads[index]["id"]
                  //                   .toString()),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     })
                ],
              ),
            )),
      ),
    );

    ///////////////
  }
}
