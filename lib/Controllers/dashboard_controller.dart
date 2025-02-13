import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_workspace/untils/export_file.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:io';

class DashboardController extends GetxController {
  final apiService = Get.put(ApiService());
  var isFormselected = false.obs;
  var selectedQuickPost = "Auto Post".obs;
  var today = ''.obs;
  var selectedPublishedorScheduled = "Published".obs;
  var selectedMediaType = "".obs;
  var selectedMediaChannels = "".obs;
  var selectedSocialPlatform = "General".obs;
  var selectedAllItem = "".obs;
  var selectedAnaliyics = "All".obs;
  var selectedSocialMediaGraph = "".obs;
  var isCustomSelected = false.obs;
  var autoPostUploadType = "image".obs;
  var selectappmethidType = "appmethod".obs;
  var sfileTpye = "image".obs;
  var choosenAutoCRMTool = "".obs;
  var userEmail = ''.obs;
/////////////////////////////
  TextEditingController imageTitleController = TextEditingController();
  TextEditingController videoTitleController = TextEditingController();
//
//
//
//

//   'constitution': 'test',
//   'city': 'test',
//   'pincode': '500033',
//   'state': 'test',
//   'issue_type': 'health'
  TextEditingController issuename = TextEditingController();
  TextEditingController issuemobile = TextEditingController();
  TextEditingController leadfor = TextEditingController();
  TextEditingController issuecontent = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController createEmail = TextEditingController();
  TextEditingController issueconstitution = TextEditingController();
  TextEditingController issuecity = TextEditingController();
  TextEditingController issuepincode = TextEditingController();
  TextEditingController issuestate = TextEditingController();

  var profileData = {}.obs;
/////
  ///
  var selectedImageobss = Rxn<File>();

  // Function to update the selected file
  void setSelectedImage(File? imageFile) {
    selectedImageobss.value = imageFile;
  }

////////////////////////for video
  // Reactive variable for the selected video
  var selectedVideos = Rxn<File>();

  // Method to update the selected image

  // Method to update the selected video
  void updateSelectedVideo(File? video) {
    selectedVideos.value = video;
    print("object");
  }
//////
  // Forvideo

  // Function to set the selected video

  // Function to initialize the video player

  // Play or pause the video

  /////
  TextEditingController v1 = TextEditingController();
  TextEditingController v2 = TextEditingController();
  TextEditingController v3 = TextEditingController();
  TextEditingController v4 = TextEditingController();
  TextEditingController v5 = TextEditingController();
  // Dev api // Dashboard Social Media
  var dashboardTotalSocialPosts = {}.obs;
  var networkCountList = [].obs;
  var dashboardTotalSocialPostsLoading = false.obs;

  // Dev api // Dashboard statictics api
  var choosenFromCategory = ''.obs;
  var dashboardTotalPosts = {}.obs;
  var dashboardTotalPostsLoading = false.obs;
  ///////////////////////////smb app
  Rx<File?> selectedImage = Rx<File?>(null);

  // Method to update the selected image
  void updateSelectedImage(File? image) {
    selectedImage.value = image;
    print("object");
  }

  // add comment and image
  var addFormLoading = false.obs;

// post issues
  // add comment and image
  var postIssueLoading = false.obs;
  Future<void> createLeads(Map payload) async {
    postIssueLoading(true);

    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.postIssuesRequest(
          endpoint: "lead/saveLead/${UserSimplePreferences.getClientId()}",
          // http://192.168.1.25:8085/api/lead/saveLead/5\

          payload: payload,
          // video: selectedVideos.value,
          image: selectedImage.value);
// https://twgpost.in/local_issues/upload/
      Map data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data["message"] == "Data saved Successfully") {
        // Fluttertoast.showToast(
        //   msg: data,
        // );
        Fluttertoast.showToast(
          msg: data["message"],
        );
        if (selectedImage.value != null) {
          updateSelectedImage(null);
        }
        Get.back();
        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }

        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      postIssueLoading(false);
    }
  }
  // lead update

  var updateLeadLoading = false.obs;
  Future<void> updateLeads(Map payload, String id) async {
    updateLeadLoading(true);

    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.updateRequest(
        endpoint: "lead/update/${id}",
        // http://192.168.1.25:8085/api/lead/saveLead/5\

        payload: payload,
        // video: selectedVideos.value,
      );
// https://twgpost.in/local_issues/upload/
      Map data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data != null) {
        // Fluttertoast.showToast(
        //   msg: data,
        // );
        getAllLeads();
        // Get.toNamed(kClientAllLeads);
        Fluttertoast.showToast(
          msg: "Updated Successfully",
        );

        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }

        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      updateLeadLoading(false);
    }
  }

  //Get hot leads
  var clienthotleads = [].obs;
  var filterclienthotleads = [].obs;
  var originalclienthotleads = [].obs;
  var hotleadsLoading = false.obs;
  Future<void> getHotLeads() async {
    hotleadsLoading(true);

    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.getFormdataRequest(
        endpoint: "lead/by-leadType/${UserSimplePreferences.getClientId()}",
        // http://192.168.1.25:8085/api/lead/by-leadType/5
      );
// https://twgpost.in/local_issues/upload/
      List data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data != null) {
        clienthotleads.value = data;
        filterclienthotleads.value = data;
        originalclienthotleads.value = data;

        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }
        print("object");
        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      hotleadsLoading(false);
    }
  }

  // All leads
  //Get hot leads
  var alleads = [].obs;
  var filteralleads = [].obs;
  var originalalleads = [].obs;

  var allleadsLoading = false.obs;
  Future<void> getAllLeads() async {
    allleadsLoading(true);

    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.getRequest(
        endpoint: "lead/${UserSimplePreferences.getClientId()}",
        //  /api/lead/5
      );
// https://twgpost.in/local_issues/upload/
      List data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data != null) {
        alleads.value = data;
        filteralleads.value = data;
        originalalleads.value = data;
        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }
        print("object");
        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      allleadsLoading(false);
    }
  }

  // LeadByID
  var leadDatabyId = {}.obs;
  var leadbyIdLoading = false.obs;
  Future<void> getLeadsID(String id) async {
    leadbyIdLoading(true);

    try {
      //

      var response = await apiService.getRequest(endpoint: "lead/getById/${id}"
          // "lead/${UserSimplePreferences.getClientId()}",
          //   /api/lead/getById/1
          );
// https://twgpost.in/local_issues/upload/
      Map data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data != null) {
        leadDatabyId.value = data;

        Get.toNamed(kUpdateLeads, arguments: leadDatabyId.value);

        print("object");
        //
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      leadbyIdLoading(false);
    }
  }

  // all business
  //Get hot leads
  var allBusinees = [].obs;
  var allBusinesLoading = false.obs;
  var selectedProject = "".obs;

  Future<void> getAllBusiness() async {
    allBusinesLoading(true);

    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.getRequest(
        endpoint: "project/getAll",
        //  /api/project/getAll
      );
// https://twgpost.in/local_issues/upload/
      List data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data != null) {
        allBusinees.value = data;
        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }
        print("object");
        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      allBusinesLoading(false);
    }
  }

  // lead list of selected day
  var selectedDayList = [].obs;
  var selectedDayListLoading = false.obs;
  Future<void> getselectedDayList() async {
    selectedDayListLoading(true);
    var payload = {"Date": choosenLeadDateByclent.value};
    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.getFormdataRequesttwo(
          endpoint: "lead/date/${UserSimplePreferences.getClientId()}",
          payload: payload
          //   /api/lead/date/5
          );
// https://twgpost.in/local_issues/upload/
      List data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data != null) {
        selectedDayList.value = data;
        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }
        print("object");
        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      selectedDayListLoading(false);
    }
  }

  //

  var eventData = <DateTime, int>{}.obs; //

  // ✅
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  var choosenLeadDateByclent = ''.obs;
  var choosenLeadDataByclent = {}.obs;
  var leadStatus = "".obs;
  // Calender leads
  var calenderLeads = [].obs;
  var calenderLeadsLoading = false.obs;
  Future<void> getAllcalenderLeads() async {
    calenderLeadsLoading(true);

    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.getRequest(
        endpoint: "lead/count-per-day/${UserSimplePreferences.getClientId()}",

        //  /api/lead/count-per-day/5
      );
// https://twgpost.in/local_issues/upload/
      //  List data = jsonDecode(response);
      List<dynamic> jsonData = json.decode(response);

// {"success":"Issue created successfully"}
      if (jsonData != null) {
        Map<DateTime, int> newEventData = {};
        for (var item in jsonData) {
          DateTime date = _normalizeDate(
              DateTime.parse(item["date"])); // Convert to DateTime
          int count = item["leadCount"];

          newEventData[date] = count; // Store in map
        }

        eventData.value = newEventData;
        print("object");
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      calenderLeadsLoading(false);
    }
  }

  /////////////////
//
  // ///
  // Future<void> uploadImage() async {
  //   addFormLoading(true);

  //   try {
  //     var response = await apiService.postRequestDonorSignupFormDatabloodBank(
  //         // payload: payload,
  //         image: selectedImage.value!);

  //     String data = response;
  //     print(data);

  //     if (data == "Accepted") {
  //       if (selectedVideos.value != null) {
  //         uploadVideo();
  //       } else {
  //         Fluttertoast.showToast(
  //           msg: "Uploaded Successfully",
  //         );
  //       }
  //       updateSelectedImage(null);
  //       // Get.toNamed(kHome);
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: data,
  //       );
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     addFormLoading(false);
  //   }
  // }

  // // video
  // Future<void> uploadVideo() async {
  //   addFormLoading(true);

  //   try {
  //     var response =
  //         await apiService.postRequestDonorSignupFormDatabloodBankvideo(
  //             // payload: payload,
  //             video: selectedVideos.value!);

  //     String data = response;
  //     print(data);

  //     if (data == "Accepted") {
  //       Fluttertoast.showToast(
  //         msg: "Files Uploaded Successfully",
  //       );
  //       updateSelectedVideo(null);
  //       // Get.toNamed(kHome);
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: data,
  //       );
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     addFormLoading(false);
  //   }
  // }
}
