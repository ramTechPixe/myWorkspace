import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';

// import 'package:dio/dio.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:my_workspace/untils/export_file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';

class ApiService extends GetxService {
//  http://192.168.1.197:5000

//
  //  String baseUrl = "http://192.168.1.25:8085/api/";
  String baseUrl = "http://192.168.1.32:8085/api/";
  //"https://thewisguystech.com/";
  String dummybaseUrl = "https://thewisguystech.com/";
  // String dummybaseUrl = "https://twgpost.in/";
  String dummybaseUrl2 = "https://apis.thewisguystech.com/";

  //https://twgpost.in/twiter-api-save-data-api/
  //  String baseUrl = "https://dev.thewisguystech.com/";  //old
  String live_baseUrl = "https://thewisguystech.com/uploads/twg-api/";
//  String baseUrl = "http://192.168.1.197:5000/"; // main
  // main
  // https://uat-hub.perfios.com/api/kyc/v3/dl
  // https://uat-hub.perfios.com/api/kyc/v2/rc
// https://uat-hub.perfios.com/api/kyc/v3/pan-profile-detailed
  final errorDict = {
    "data": [
      {"error": "Please check your internet connection."}
    ],
    "status": "error"
  };
  ////////////TWG APIS SERVICES
  ///Live apis
  Future<dynamic> livegetRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(live_baseUrl + endpoint);
    try {
      // var header = {
      //   "Authorization": '${UserSimplePreferences.getToken()}',
      //   //  "accept": 'application/json'
      // };
      var response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

///////////////////////
//////////////////////// post issues
  Future postIssuesRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
    File? image,
    File? video,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    var headers = {
      'Authorization': '${UserSimplePreferences.getToken()}',
      'Content-Type': 'multipart/form-data',
    };
    try {
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['leadType'] = payload['leadType'] ?? ""
        ..fields['address'] = payload['address'] ?? ""
        ..fields['bussinessType'] = payload['bussinessType'] ?? ""
        ..fields['mailId'] = payload['mailId'] ?? ""
        ..fields['mobileNumber'] = payload['mobileNumber'] ?? ""
        ..fields['bussinessName'] = payload['bussinessName'] ?? ""
        ..fields['leadFor'] = payload['leadFor'] ?? "";
      // ..fields['volunter_id'] = payload['volunter_id'] ?? ""
      // ..fields['name'] = payload['name'] ?? ""
      // ..fields['mobile_number'] = payload['mobile_number'] ?? ""
      // ..fields['subject'] = payload['subject'] ?? ""
      // ..fields['content'] = payload['content'] ?? ""
      // ..fields['village'] = payload['village'] ?? ""
      // ..fields['mandal'] = payload['mandal'] ?? ""
      // ..fields['constitution'] = payload['constitution'] ?? ""

      // ////
      // ..fields['city'] = payload['city'] ?? ""
      // ..fields['pincode'] = payload['pincode'] ?? ""
      // ..fields['state'] = payload['state'] ?? ""
      // ..fields['issue_type'] = payload['issue_type'] ?? "";

      if (image != null && image.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', 'png'),
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // update Request
  Future updateRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    var headers = {
      'Authorization': '${UserSimplePreferences.getToken()}',
      'Content-Type': 'multipart/form-data',
    };
    try {
      var request = http.MultipartRequest('PUT', url)
        ..headers.addAll(headers)
        ..fields['leadType'] = payload['leadType'] ?? "";

      // ..fields['volunter_id'] = payload['volunter_id'] ?? ""
      // ..fields['name'] = payload['name'] ?? ""
      // ..fields['mobile_number'] = payload['mobile_number'] ?? ""
      // ..fields['subject'] = payload['subject'] ?? ""
      // ..fields['content'] = payload['content'] ?? ""
      // ..fields['village'] = payload['village'] ?? ""
      // ..fields['mandal'] = payload['mandal'] ?? ""
      // ..fields['constitution'] = payload['constitution'] ?? ""

      // ////
      // ..fields['city'] = payload['city'] ?? ""
      // ..fields['pincode'] = payload['pincode'] ?? ""
      // ..fields['state'] = payload['state'] ?? ""
      // ..fields['issue_type'] = payload['issue_type'] ?? "";

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // Get hot leads Form data
  Future getFormdataRequest({
    required String endpoint,
    // required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    var headers = {
      'Authorization': '${UserSimplePreferences.getToken()}',
      'Content-Type': 'multipart/form-data',
    };
    try {
      var request = http.MultipartRequest('GET', url)
        ..headers.addAll(headers)
        ..fields['leadType'] = "hotlead";

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  Future getFormdataRequesttwo({
    required String endpoint,
    required Map payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    var headers = {
      'Authorization': '${UserSimplePreferences.getToken()}',
      'Content-Type': 'multipart/form-data',
    };
    try {
      var request = http.MultipartRequest('GET', url)
        ..headers.addAll(headers)
        ..fields['Date'] = payload['Date'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

/////
  //PostRequestCoupons
  Future postRequestSignUpCouponsFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['coupon_code'] = payload['coupon_code'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////
  Future postRequestSignInFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_email'] = payload['user_email']
        ..fields['user_password'] = payload['user_password'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //// Post ScheduleList
  Future postRequestScheduleData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // v2 razottools
  Future postRequestrazoTools({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['tool_id'] = payload['tool_id']
        ..fields['user_id'] = payload['user_id'];
      //
      //       'tool_id': '4',
      // 'user_id': '3'
      //

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  //// Post ScheduleList
  Future postRequestScheduleDataAccounts({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
/////////////////////////////////////////////////////

// curl --location 'https://apis.thewisguystech.com/create-comments' \
// --form 'user_id="80"' \
// --form 'service_type="auto_reply_negitive_comments_delete"' \
// --form 'account_link="https://www.instagram.com/bharatsports11/"' \
// --form 'email="saiteja@gmail.com"' \
// --form 'mobile="8686180840"' \
// --form 'demo_schedule="2024-10-23T10:30"' \
// --form 'name="sai"' \
// --form 'company_name="sai"'
////////////////////////////////
  /// menus
  Future postRequestAutoComments({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        // ..fields['user_id'] = "5"
        // ..fields['service_type'] = "auto_reply_negitive_comments_delete"
        // ..fields['account_link'] = "https://www.instagram.com/bharatsports11/"
        // ..fields['email'] = "saiteja@gmail.com"
        // ..fields['mobile'] = "8686180840"
        // ..fields['demo_schedule'] = "2024-10-23T10:30"
        // ..fields['name'] = "sai"
        // ..fields['company_name'] = "sai";
        ..fields['user_id'] = payload['user_id']
        ..fields['service_type'] = payload['service_type']
        ..fields['account_link'] = payload['account_link']
        ..fields['email'] = payload['email']
        ..fields['mobile'] = payload['mobile']
        ..fields['demo_schedule'] = payload['demo_schedule']
        ..fields['name'] = payload['name']
        ..fields['company_name'] = payload['company_name'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // create Digital influencer
  Future postRequestCreateDigitalInfluence({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['gender'] = payload['gender']
        ..fields['age'] = payload['age']
        ..fields['country'] = payload['country']
        ..fields['looks'] = payload['looks']
        ..fields['dress'] = payload['dress']
        ..fields['background'] = payload['background'];
      // ..fields['user_id'] = payload['user_id']
      // ..fields['service_type'] = payload['service_type']
      // ..fields['account_link'] = payload['account_link']
      // ..fields['email'] = payload['email']
      // ..fields['mobile'] = payload['mobile']
      // ..fields['demo_schedule'] = payload['demo_schedule']
      // ..fields['name'] = payload['name']
      // ..fields['company_name'] = payload['company_name'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // save digital
  Future savepostRequestCreateDigitalInfluence({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['gender'] = payload['gender']
        // ..fields['gender'] = payload['gender']
        ..fields['age'] = payload['age']
        ..fields['country'] = payload['country']
        ..fields['looks'] = payload['looks']
        ..fields['dress'] = payload['dress']
        ..fields['background'] = payload['background']
        ..fields['image_url'] = payload['image_url']
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// logo
  Future postRequestlogo({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['words'] = payload['words']
        ..fields['tagline'] = payload['tagline']
        ..fields['subject'] = payload['subject']
        ..fields['style'] = payload['style'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// create music
// logo
  Future postRequestMusic({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['musictype'] = payload['musictype']
        ..fields['instrument'] = payload['instrument'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // fb crm
  Future postRequestfbCrm({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['name'] = payload['name']
        ..fields['email'] = payload['email']
        ..fields['phone_number'] = payload['phone_number']
        ..fields['facebook_page_link'] = payload['facebook_page_link']
        ..fields['ad_link'] = payload['ad_link']
        ..fields['form_type'] = payload['form_type']
        ..fields['user_id'] = payload['user_id'];
      // ..fields['user_id'] = payload['user_id']
      // ..fields['musictype'] = payload['musictype']
      // ..fields['instrument'] = payload['instrument'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// web
  Future postRequestWebCrm({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['name'] = payload['name']
        ..fields['email'] = payload['email']
        ..fields['phone_number'] = payload['phone_number']
        ..fields['website_link'] = payload['website_link']
        ..fields['form_type'] = payload['form_type']
        ..fields['user_id'] = payload['user_id'];
      // ..fields['user_id'] = payload['user_id']
      // ..fields['musictype'] = payload['musictype']
      // ..fields['instrument'] = payload['instrument'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//// fb2Crm
  Future postRequestFacebook2Crm({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['own'] = payload['own']
        ..fields['services'] = payload['services']
        ..fields['name'] = payload['name']
        ..fields['email'] = payload['email']
        ..fields['mobile'] = payload['mobile']
        ..fields['city'] = payload['city']
        ..fields['company_name'] = payload['company_name']
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

////////////////
// logo
  Future postRequestAiblog({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['blog_title'] = payload['blog_title']
        ..fields['content_source'] = payload['content_source']
        ..fields['language'] = payload['language'];
      // ..fields['user_id'] = payload['user_id']
      // ..fields['musictype'] = payload['musictype']
      // ..fields['instrument'] = payload['instrument'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// pose
  Future postRequestPose({
    File? profilePic,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['influencer_id'] = payload['influencer_id'];
      request.files.add(await http.MultipartFile.fromPath(
        'pose_image',
        profilePic!.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  // Future postRequestPose({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(dummybaseUrl2 + endpoint);

  //   try {
  //     var request = http.MultipartRequest('POST', url)
  //       ..fields['user_id'] = payload['user_id']
  //       ..fields['influencer_id'] = payload['influencer_id']
  //       ..fields['pose_image'] = payload['pose_image'];
  //     // ..fields['user_id'] = payload['user_id']
  //     // ..fields['musictype'] = payload['musictype']
  //     // ..fields['instrument'] = payload['instrument'];
  //     // ..fields['gender'] = payload['gender']
  //     // ..fields['age'] = payload['age']
  //     // ..fields['country'] = payload['country']
  //     // ..fields['looks'] = payload['looks']
  //     // ..fields['dress'] = payload['dress']
  //     // ..fields['background'] = payload['background'];

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  // hash tags
  Future postRequestHashtags({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['headings_or_input'] = payload['headings_or_input'];

      // ..fields['user_id'] = payload['user_id']
      // ..fields['musictype'] = payload['musictype']
      // ..fields['instrument'] = payload['instrument'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

///////
  ///
  // save logo
  Future savepostRequestlogo({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['words'] = payload['words']
        ..fields['subject'] = payload['subject']
        ..fields['style'] = payload['style']
        ..fields['tagline'] = payload['tagline']
        ..fields['image_url'] = payload['image_url'];
      // ..fields['gender'] = payload['gender']
      // ..fields['age'] = payload['age']
      // ..fields['country'] = payload['country']
      // ..fields['looks'] = payload['looks']
      // ..fields['dress'] = payload['dress']
      // ..fields['background'] = payload['background'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

///////////seo
  Future postRequestSeo({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        // ..fields['user_id'] = "5"
        // ..fields['service_type'] = "auto_reply_negitive_comments_delete"
        // ..fields['account_link'] = "https://www.instagram.com/bharatsports11/"
        // ..fields['email'] = "saiteja@gmail.com"
        // ..fields['mobile'] = "8686180840"
        // ..fields['demo_schedule'] = "2024-10-23T10:30"
        // ..fields['name'] = "sai"
        // ..fields['company_name'] = "sai";

        ..fields['website_url'] = payload['website_url'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///

  // meta face book
  Future postRequestMetaFacebookpostType({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
//  'post_id': '146',
//       'meta_key': '_sap_fb_post_type',
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['post_id'] = payload['post_id']
        ..fields['meta_key'] = payload['meta_key'];
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  Future postRequestrazorPayid({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
//  'post_id': '146',
//       'meta_key': '_sap_fb_post_type',
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_plan'] = payload['sap_plan'];
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//// auto message v2
  Future postRequestAiTextData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
//  "user_id": userprofilecontroller.profileData["user_details"]["id"],
    //    "custom_message": paylodd["customMesg"]
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['heading'] = payload['heading'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // aitext caption v2
  Future postRequestAiTextDataV2({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    // number_of_words
    // sap_ai_content_link
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['number_of_words'] = payload['number_of_words']
        ..fields['sap_ai_content_link'] = payload['sap_ai_content_link'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  Future postRequestTwitterSavedummyurl({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_twitter_options[twitter_keys][0][consumer_key]'] =
            payload['sap_twitter_options[twitter_keys][0][consumer_key]']
        ..fields['sap_twitter_options[twitter_keys][0][consumer_secret]'] =
            payload['sap_twitter_options[twitter_keys][0][consumer_secret]']
        ..fields['sap_twitter_options[twitter_keys][0][oauth_token]'] =
            payload['sap_twitter_options[twitter_keys][0][oauth_token]']
        ..fields['sap_twitter_options[twitter_keys][0][oauth_secret]'] =
            payload['sap_twitter_options[twitter_keys][0][oauth_secret]']
        // ..fields['sap_twitter_options[tweet_image]'] =
        //     payload['sap_twitter_options[tweet_image]']
        ..fields['sap_twitter_options[tw_type_shortner_opt]'] =
            payload['sap_twitter_options[tw_type_shortner_opt]']
        ..fields['sap_twitter_options[tw_bitly_access_token]'] =
            payload['sap_twitter_options[tw_bitly_access_token]']
        ..fields['sap_twitter_options[tw_shortest_api_token]'] =
            payload['sap_twitter_options[tw_shortest_api_token]']
        ..fields['limit_twitter_count'] = payload['limit_twitter_count']
        ..fields['created_twitter_count'] = payload['created_twitter_count']
        ..fields['sap_twitter_submit'] = payload['sap_twitter_submit']
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////////////////////save payment
  Future postRequestsavePayment({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['additionalData[form-submitted]'] =
            payload['additionalData[form-submitted]'] ?? ''
        ..fields['additionalData[sap_firstname]'] =
            payload['additionalData[sap_firstname]'] ?? ''
        ..fields['additionalData[sap_lastname]'] =
            payload['additionalData[sap_lastname]'] ?? ''
        ..fields['additionalData[sap_email]'] =
            payload['additionalData[sap_email]'] ?? ''
        ..fields['additionalData[sap_password]'] =
            payload['additionalData[sap_password]'] ?? ''
        ..fields['additionalData[sap_repassword]'] =
            payload['additionalData[sap_repassword]'] ?? ''
        ..fields['additionalData[sap_role]'] =
            payload['additionalData[sap_role]'] ?? ''
        ..fields['additionalData[sap_plan]'] =
            payload['additionalData[sap_plan]'] ?? ''
        ..fields['additionalData[gateway_type]'] =
            payload['additionalData[gateway_type]'] ?? ''
        ..fields['razorpay_payment_id'] = payload['razorpay_payment_id'] ?? ''
        ..fields['subscription_id'] = payload['subscription_id'] ?? ''
        ..fields['plan_price'] = payload['plan_price'] ?? ''
        ..fields['apply_coupon'] = payload['apply_coupon'] ?? '';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // save tools payment
  Future postRequestsavetoolsPayment({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        //     '': '1',
        // '': '3',
        // '': 'pay_PC6Q02JsvKUtC6',
        // '': '1',
        // '': '20',
        // '': 'saiteja',
        // 'customer_email': 'saiteja@gmail.com',
        // 'payment_date': '2024-12-26'
        ..fields['tool_id'] = payload['tool_id'] ?? ''
        ..fields['user_id'] = payload['user_id'] ?? ''
        ..fields['razorpay_payment_id'] = payload['razorpay_payment_id'] ?? ''
        ..fields['payment_amount'] = payload['payment_amount'] ?? ''
        ..fields['max_hits'] = payload['max_hits'] ?? ''
        ..fields['customer_name'] = payload['customer_name'] ?? ''
        ..fields['customer_email'] = payload['customer_email'] ?? ''
        ..fields['payment_date'] = payload['payment_date'] ?? '';
      // ..fields['additionalData[form-submitted]'] =
      //     payload['additionalData[form-submitted]'] ?? ''
      // ..fields['additionalData[sap_firstname]'] =
      //     payload['additionalData[sap_firstname]'] ?? ''
      // ..fields['additionalData[sap_lastname]'] =
      //     payload['additionalData[sap_lastname]'] ?? ''
      // ..fields['additionalData[sap_email]'] =
      //     payload['additionalData[sap_email]'] ?? ''
      // ..fields['additionalData[sap_password]'] =
      //     payload['additionalData[sap_password]'] ?? ''
      // ..fields['additionalData[sap_repassword]'] =
      //     payload['additionalData[sap_repassword]'] ?? ''
      // ..fields['additionalData[sap_role]'] =
      //     payload['additionalData[sap_role]'] ?? ''
      // ..fields['additionalData[sap_plan]'] =
      //     payload['additionalData[sap_plan]'] ?? ''
      // ..fields['additionalData[gateway_type]'] =
      //     payload['additionalData[gateway_type]'] ?? ''
      // ..fields['razorpay_payment_id'] = payload['razorpay_payment_id'] ?? ''
      // ..fields['subscription_id'] = payload['subscription_id'] ?? ''
      // ..fields['plan_price'] = payload['plan_price'] ?? ''
      // ..fields['apply_coupon'] = payload['apply_coupon'] ?? '';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///

// graphs
  Future postRequestGraphs({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['social_type'] = payload['social_type'] ?? ''
        ..fields['start_date'] = payload['start_date'] ?? ''
        ..fields['end_date'] = payload['end_date'] ?? ''
        ..fields['filter_type'] = payload['filter_type'] ?? ''
        ..fields['user_id'] = payload['user_id'] ?? '';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//
  // tumbler save
  Future postRequestTumblerSavedummyurl({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_tumblr_options[post_content_size]'] =
            payload['sap_tumblr_options[post_content_size]']
        ..fields['sap_tumblr_options[tumblr_keys][0][tumblr_consumer_key]'] =
            payload['sap_tumblr_options[tumblr_keys][0][tumblr_consumer_key]']
        ..fields['sap_tumblr_options[tumblr_keys][0][tumblr_consumer_secret]'] =
            payload[
                'sap_tumblr_options[tumblr_keys][0][tumblr_consumer_secret]']
        ..fields['sap_tumblr_options[tumblr_keys][1][tumblr_consumer_key]'] =
            payload['sap_tumblr_options[tumblr_keys][1][tumblr_consumer_key]']
        ..fields['sap_tumblr_options[tumblr_keys][1][tumblr_consumer_secret]'] =
            payload[
                'sap_tumblr_options[tumblr_keys][1][tumblr_consumer_secret]']
        ..fields['sap_tumblr_options[posting_type]'] =
            payload['sap_tumblr_options[posting_type]']
        ..fields['sap_tumblr_options[tumblr_link]'] =
            payload['sap_tumblr_options[tumblr_link]']
        ..fields['sap_tumblr_options[tu_type_shortner_opt]'] =
            payload['sap_tumblr_options[tu_type_shortner_opt]']
        ..fields['sap_tumblr_options[tu_bitly_access_token]'] =
            payload['sap_tumblr_options[tu_bitly_access_token]']
        ..fields['sap_tumblr_options[tu_shortest_api_token]'] =
            payload['sap_tumblr_options[tu_shortest_api_token]']
        ..fields['limit_tumbir_count'] = payload['limit_tumbir_count']
        ..fields['created_tumbir_count'] = payload['created_tumbir_count']
        ..fields['sap_tumblr_submit'] = payload['sap_tumblr_submit']
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // semiautomation // publish Post
  Future postRequestQuickPostPublish({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ///////////////////
        ..fields['user_id'] = payload['user_id']!
        ..fields['enable_video_image'] = payload['enable_video_image']!
        ..fields['custom_share_link'] = payload['custom_share_link'] ?? ""
        ..fields['networks[facebook]'] = payload['networks[facebook]']!
        ..fields['networks[fb_accounts][0]'] =
            payload['networks[fb_accounts][0]']!
        ..fields['status'] = payload['status']!
        ..fields['message'] = payload['message']!
        ..fields['share_link'] = payload['share_link'] ?? ""
        ..fields['sap-schedule-time-fb'] = payload['sap-schedule-time-fb']!
        ..fields['sap-schedule-time-tw'] = payload['sap-schedule-time-tw'] ?? ""
        ..fields['sap-schedule-time-youtube'] =
            payload['sap-schedule-time-youtube'] ?? ""
        ..fields['sap-schedule-time-tumblr'] =
            payload['sap-schedule-time-tumblr'] ?? ""
        ..fields['sap-schedule-time-pin'] =
            payload['sap-schedule-time-pin'] ?? ""
        ..fields['sap-schedule-time-instagram'] =
            payload['sap-schedule-time-instagram'] ?? ""
        ..fields['sap-schedule-time'] = payload['sap-schedule-time'] ?? "";
      ///////////////
      // ..fields['sap_tumblr_options[post_content_size]'] =
      //     payload['sap_tumblr_options[post_content_size]']
      // ..fields['sap_tumblr_options[tumblr_keys][0][tumblr_consumer_key]'] =
      //     payload['sap_tumblr_options[tumblr_keys][0][tumblr_consumer_key]']
      // ..fields['sap_tumblr_options[tumblr_keys][0][tumblr_consumer_secret]'] =
      //     payload[
      //         'sap_tumblr_options[tumblr_keys][0][tumblr_consumer_secret]']
      // ..fields['sap_tumblr_options[tumblr_keys][1][tumblr_consumer_key]'] =
      //     payload['sap_tumblr_options[tumblr_keys][1][tumblr_consumer_key]']
      // ..fields['sap_tumblr_options[tumblr_keys][1][tumblr_consumer_secret]'] =
      //     payload[
      //         'sap_tumblr_options[tumblr_keys][1][tumblr_consumer_secret]']
      // ..fields['sap_tumblr_options[posting_type]'] =
      //     payload['sap_tumblr_options[posting_type]']
      // ..fields['sap_tumblr_options[tumblr_link]'] =
      //     payload['sap_tumblr_options[tumblr_link]']
      // ..fields['sap_tumblr_options[tu_type_shortner_opt]'] =
      //     payload['sap_tumblr_options[tu_type_shortner_opt]']
      // ..fields['sap_tumblr_options[tu_bitly_access_token]'] =
      //     payload['sap_tumblr_options[tu_bitly_access_token]']
      // ..fields['sap_tumblr_options[tu_shortest_api_token]'] =
      //     payload['sap_tumblr_options[tu_shortest_api_token]']
      // ..fields['limit_tumbir_count'] = payload['limit_tumbir_count']
      // ..fields['created_tumbir_count'] = payload['created_tumbir_count']
      // ..fields['sap_tumblr_submit'] = payload['sap_tumblr_submit']
      // ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // add or save Multipost
  // tumbler save
  Future postRequestAddSaveMultipost({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['body'] = payload['body']
        ..fields['share_link'] = payload['share_link']
        ..fields['sap_facebook[accounts][0]'] =
            payload['sap_facebook[accounts][0]']
        ..fields['sap_facebook[type]'] = payload['sap_facebook[type]']
        ..fields['sap_facebook[message]'] = payload['sap_facebook[message]']
        ..fields['sap_facebook_custom_link'] =
            payload['sap_facebook_custom_link']
        ..fields['sap_facebbok_post_img'] = payload['sap_facebbok_post_img']
        ..fields['sap-schedule-time-fb'] = payload['sap-schedule-time-fb']
        ..fields['networks[facebook]'] = payload['networks[facebook]']
        ..fields['networks[twitter]'] = payload['networks[twitter]']
        ..fields['networks[linkedin]'] = payload['networks[linkedin]']
        ..fields['networks[tumblr]'] = payload['networks[tumblr]']
        ..fields['networks[pinterest]'] = payload['networks[pinterest]']
        ..fields['networks[gmb]'] = payload['networks[gmb]']
        ..fields['networks[instagram]'] = payload['networks[instagram]']
        ..fields['sap_twitter_user_id[0]'] = payload['sap_twitter_user_id[0]']
        ..fields['sap_tweet_img'] = payload['sap_tweet_img']
        ..fields['sap_twitter_msg'] = payload['sap_twitter_msg']
        ..fields['sap-schedule-time-tw'] = payload['sap-schedule-time-tw']
        ..fields['sap_linkedin_custom_link'] =
            payload['sap_linkedin_custom_link']
        ..fields['sap_linkedin_post_img'] = payload['sap_linkedin_post_img']
        ..fields['sap_linkedin_custom_title'] =
            payload['sap_linkedin_custom_title']
        ..fields['sap_linkedin_custom_description'] =
            payload['sap_linkedin_custom_description']
        ..fields['sap-schedule-time-li'] = payload['sap-schedule-time-li']
        ..fields['sap_tumblr_user_id[0]'] = payload['sap_tumblr_user_id[0]']
        ..fields['sap_tumblr_posting_type'] = payload['sap_tumblr_posting_type']
        ..fields['sap_tumblr_custom_link'] = payload['sap_tumblr_custom_link']
        ..fields['sap_tumblr_post_img'] = payload['sap_tumblr_post_img']
        ..fields['sap_tumblr_custom_description'] =
            payload['sap_tumblr_custom_description']
        ..fields['sap-schedule-time-tumblr'] =
            payload['sap-schedule-time-tumblr']
        ..fields['sap_pinterest[accounts][0]'] =
            payload['sap_pinterest[accounts][0]']
        ..fields['sap_pinterest[message]'] = payload['sap_pinterest[message]']
        ..fields['sap_pinterest_custom_link'] =
            payload['sap_pinterest_custom_link']
        ..fields['sap_pinterest_post_img'] = payload['sap_pinterest_post_img']
        ..fields['sap-schedule-time-pin'] = payload['sap-schedule-time-pin']
        ..fields['sap_gmb[gmb_button_type]'] =
            payload['sap_gmb[gmb_button_type]']
        ..fields['sap_gmb[message]'] = payload['sap_gmb[message]']
        ..fields['sap_gmb_custom_link'] = payload['sap_gmb_custom_link']
        ..fields['sap_gmb_post_img'] = payload['sap_gmb_post_img']
        ..fields['sap-schedule-time-gmb'] = payload['sap-schedule-time-gmb']
        ..fields['sap_instagram[accounts][0]'] =
            payload['sap_instagram[accounts][0]']
        ..fields['sap_instagram[message]'] = payload['sap_instagram[message]']
        ..fields['sap_instagram_post_img'] = payload['sap_instagram_post_img']
        ..fields['sap-schedule-time-instagram'] =
            payload['sap-schedule-time-instagram']
        ..fields['sap-schedule-time'] = payload['sap-schedule-time']
        ..fields['status'] = payload['status']
        ..fields['form-submitted'] = payload['form-submitted']
        ..fields['img'] = payload['img']
        ..fields['individual_status'] = payload['individual_status']
        ..fields['ip'] = payload['ip']
        ..fields['created_date'] = payload['created_date']
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //  pinterest
  Future postRequestPinterestSavedummyurl({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl + endpoint);
    ////////////////////////////////////////////////////////////////

    ////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_pinterest_options[proxy_url]'] =
            payload['sap_pinterest_options[proxy_url]']
        ..fields['sap_pinterest_options[proxy_username]'] =
            payload['sap_pinterest_options[proxy_username]']
        ..fields['sap_pinterest_options[proxy_password]'] =
            payload['sap_pinterest_options[proxy_password]']
        ..fields['sap_pinterest_options[pin_auth_options]'] =
            payload['sap_pinterest_options[pin_auth_options]']
        ..fields['sap_pinterest_options[pinterest_keys][0][app_id]'] =
            payload['sap_pinterest_options[pinterest_keys][0][app_id]']
        ..fields['sap_pinterest_options[pinterest_keys][0][app_secret]'] =
            payload['sap_pinterest_options[pinterest_keys][0][app_secret]']
        ..fields['sap_pinterest_options[pin_image]'] =
            payload['sap_pinterest_options[pin_image]']
        ..fields['sap_pinterest_options[pin_type_shortner_opt]'] =
            payload['sap_pinterest_options[pin_type_shortner_opt]']
        ..fields['sap_pinterest_options[pin_bitly_access_token]'] =
            payload['sap_pinterest_options[pin_bitly_access_token]']
        ..fields['sap_pinterest_options[pin_shortest_api_token]'] =
            payload['sap_pinterest_options[pin_shortest_api_token]']
        ..fields['limit_pinterest_count'] = payload['limit_pinterest_count']
        ..fields['created_pinterest_count'] = payload['created_pinterest_count']
        ..fields['sap-pinterest-cookie'] = payload['sap-pinterest-cookie']
        ..fields['sap_pinterest_submit'] = payload['sap_pinterest_submit']
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  //
  // ..fields['sap_pinterest_options[proxy_url]'] =
  //       payload['sap_pinterest_options[proxy_url]']
  //   ..fields['sap_pinterest_options[proxy_username]'] =
  //       payload['sap_pinterest_options[proxy_username]']
  //   ..fields['sap_pinterest_options[proxy_password]'] =
  //       payload['sap_pinterest_options[proxy_password]']
  //   ..fields['sap_pinterest_options[pin_auth_options]'] =
  //       payload['sap_pinterest_options[pin_auth_options]']
  //   ..fields['sap_pinterest_options[pinterest_keys][0][app_id]'] =
  //       payload['sap_pinterest_options[pinterest_keys][0][app_id]']
  //   ..fields['sap_pinterest_options[pinterest_keys][0][app_secret]'] =
  //       payload['sap_pinterest_options[pinterest_keys][0][app_secret]']
  //   ..fields['sap_pinterest_options[pin_image]'] =
  //       payload['sap_pinterest_options[pin_image]']
  //   ..fields['sap_pinterest_options[pin_type_shortner_opt]'] =
  //       payload['sap_pinterest_options[pin_type_shortner_opt]']
  //   ..fields['sap_pinterest_options[pin_bitly_access_token]'] =
  //       payload['sap_pinterest_options[pin_bitly_access_token]']
  //   ..fields['sap_pinterest_options[pin_shortest_api_token]'] =
  //       payload['sap_pinterest_options[pin_shortest_api_token]']
  //   ..fields['limit_pinterest_count'] = payload['limit_pinterest_count']
  //   ..fields['created_pinterest_count'] = payload['created_pinterest_count']
  //   ..fields['sap-pinterest-cookie'] = payload['sap-pinterest-cookie']
  //   ..fields['sap_pinterest_submit'] = payload['sap_pinterest_submit']
  //   ..fields['user_id'] = payload['user_id'];

  //

  // youtube save
  Future postRequestYoutubeSavedummyurl({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl + endpoint);

    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        if (customHeaders != null) ...customHeaders,
      };

      var encodedPayload = payload.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');

      var response = await http.post(
        url,
        headers: headers,
        body: encodedPayload,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return {"message": response.reasonPhrase ?? "Request failed!"};
      }
    } catch (e) {
      debugPrint("Error occurred: $e");
      return {"message": "Something went wrong!"};
    }
  }

/////
  // post view
  Future postRequestPostViewData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['log_id'] = payload['log_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // multipost By ID
  // multipost pagenation
  Future postRequestMultipostv2ID({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['post_id'] = payload['post_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  // multipost pagenation
  Future postRequestMultipostv2({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // multipost pagenation
  Future postRequestMultipostPagenation({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['page'] = payload['page']
        ..fields['limit'] = payload['limit'];
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // post view
  Future postRequestScheduleViewData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['post_id'] = payload['post_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///
  ///
  Future postRequestDeleteLogData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['log_id'] = payload['log_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /// multilogs delete // first
  // Future postRequestMultiIDDeleteLogData({
  //   required String endpoint,
  //   required List<dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);

  //   try {
  //     var request = http.MultipartRequest('POST', url);

  //     for (var i = 0; i < payload.length; i++) {
  //       request.fields['id[]'] = payload[i].toString();
  //     }

  //     if (customHeaders != null) {
  //       request.headers.addAll(customHeaders);
  //     }

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     } else {
  //       return {
  //         "message": "Request failed with status: ${response.statusCode}"
  //       };
  //     }
  //   } catch (e) {
  //     debugPrint("$e");
  //     return {"message": "Something went wrong!"};
  //   }
  // }
  Future postRequestMultiIDDeleteLogData({
    required String endpoint,
    required List payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url);

      for (var id in payload) {
        request.fields.addAll({'id[]': id.toString()});
      }

      if (customHeaders != null) {
        request.headers.addAll(customHeaders);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return {
          "message": "Request failed with status: ${response.statusCode}"
        };
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

// multi delete Posts // first
  // Future postRequestMultiIDDeleteMultiPosts({
  //   required String endpoint,
  //   required List<dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);

  //   try {
  //     var request = http.MultipartRequest('POST', url);

  //     for (var i = 0; i < payload.length; i++) {
  //       request.fields['post_id[]'] = payload[i].toString();
  //     }

  //     if (customHeaders != null) {
  //       request.headers.addAll(customHeaders);
  //     }

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     } else {
  //       return {
  //         "message": "Request failed with status: ${response.statusCode}"
  //       };
  //     }
  //   } catch (e) {
  //     debugPrint("$e");
  //     return {"message": "Something went wrong!"};
  //   }
  // }
  // second
  // Future postRequestMultiIDDeleteMultiPosts({
  //   required String endpoint,
  //   required List payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);

  //   try {
  //     var request = http.MultipartRequest('POST', url);

  //     for (String id in payload) {
  //       request.fields.addAll({'post_id[]': id});
  //       // request.fields['post_id[]'] = id;
  //     }
  //     print(request.fields);
  //     if (customHeaders != null) {
  //       request.headers.addAll(customHeaders);
  //     }

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     } else {
  //       return {
  //         "message": "Request failed with status: ${response.statusCode}"
  //       };
  //     }
  //   } catch (e) {
  //     debugPrint("$e");
  //     return {"message": "Something went wrong!"};
  //   }
  // }
  // third
  Future postRequestMultiIDDeleteMultiPosts({
    required String endpoint,
    required List<String> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url);

      // Add each item to 'post_id[]' dynamically
      for (String id in payload) {
        request.fields.addAll({'post_id[]': id});
      }

      print("Fields to be sent: ${request.fields}"); // Debug: Verify the fields

      // Add custom headers if provided
      if (customHeaders != null) {
        request.headers.addAll(customHeaders);
      }

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return {
          "message": "Request failed with status: ${response.statusCode}"
        };
      }
    } catch (e) {
      debugPrint("Error: $e");
      return {"message": "Something went wrong!"};
    }
  }
  // fourth dio

// edit profile
  Future postRequestEditProfileFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_user_id'] = payload['sap_user_id']
        ..fields['sap_user_fname'] = payload['sap_user_fname']
        ..fields['sap_user_lname'] = payload['sap_user_lname']
        ..fields['sap_user_email'] = payload['sap_user_email'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //Password
  Future postRequestEditProfilePasswordFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_user_id'] = payload['sap_user_id']
        ..fields['sap_user_fname'] = payload['sap_user_fname']
        ..fields['sap_user_lname'] = payload['sap_user_lname']
        ..fields['sap_user_email'] = payload['sap_user_email']
        ..fields['sap_user_password'] = payload['sap_user_password'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  Future<dynamic> getRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": '${UserSimplePreferences.getToken()}',
        //  "accept": 'application/json'
      };
      var response = await http.get(url, headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////////////////////////
  Future putRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.put("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  String imagebaseUrl = "http://43.205.34.80:8001/";
  Future putProfileRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var response = await http.put(url, headers: header, body: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////
  Future patchRequestEditProfile({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'profilePic',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// Upload Resume
  Future patchRequestUploadResume({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'resume',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// Upload Resume
  Future patchRequestUploadLetters({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'experienceLetter',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// (File license, File pan, File adhar,
//       File authenticationImage, File rc)
  /////////////////////////////Upload DOcs Captain
  Future patchRequestUploadDocs({
    required File license,
    required File pan,
    required File adhar,
    required File authenticationImage,
    required File rc,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'license',
        license.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'pan',
        pan.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        authenticationImage.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'rc',
        rc.path,
        contentType: MediaType('image', 'png'),
      ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  Future patchRequestUploadVrefiDocs({
    required File pan,
    required File adhar,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'pan',
        pan.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////

  ///////////////////User Upload DOcs
  Future patchRequestUserUploadDocs({
    required File authenticationImage,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        authenticationImage.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////CaptainDutyAPi///////////////////////////
  Future patchRequestCaptainDuty({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'captainLiveImage',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////////////

  //////////
  ///
  Future patchRequestEditProfilebank({
    required File profilePic,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}'
        ..fields['bloodBankName'] = payload['bloodBankName'];
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profilePic.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future postRequestwithImageandToken({
    required File profilePic,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}'
        ..fields['leaveType'] = payload['leaveType']
        ..fields['dateRange'] = payload['dateRange']
        ..fields['reason'] = payload['reason'];

      request.files.add(await http.MultipartFile.fromPath(
        'documente',
        profilePic.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///Post  request form data
  Future postRequestDonorSignupFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('POST', url)
        // ..headers['Authorization'] =
        //     'Bearer ${UserSimplePreferences.getToken()}'  // termsAndCondition
        ..fields['email'] = payload['email']
        ..fields['password'] = payload['password']
        ..fields['firstName'] = payload['firstName']
        ..fields['lastName'] = payload['lastName']
        ..fields['empId'] = payload['empId']
        ..fields['dateOfBirth'] = payload['dateOfBirth']
        ..fields['role'] = payload['role']
        ..fields['gender'] = payload['gender']
        ..fields['companyName'] = payload['companyName']
        ..fields['termsAndCondition'] = payload['termsAndCondition'];

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

///////////////////////
//{
  // "dropLangitude": "17.413973667114202",
//  "dropLongitude": "78.37360815684931",
  // "pickupLangitude": "17.419151642685726",
  // "pickupLongitude": "78.3889548353466",
//  "pickupAddress": "Raidurg",
  // "dropAddress": "Sutherland",
  // "price": "250",
  // "orderPlaceTime": "08:09 AM",
  // "orderPlaceDate": "04-07-2024",
  // "vehicleType": "bike"
//}
///////////////////
  // UserBookRide with Image
  ////////////////////////////////////////////////////////////////////////////////////////

  Future postRequestUserBookFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    required String token,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['dropLangitude'] = payload['dropLangitude']
        ..fields['dropLongitude'] = payload['dropLongitude']
        ..fields['pickupLangitude'] = payload['pickupLangitude']
        ..fields['pickupLongitude'] = payload['pickupLongitude']
        ..fields['pickupAddress'] = payload['pickupAddress']
        ..fields['dropAddress'] = payload['dropAddress']
        ..fields['price'] = payload['price']
        ..fields['orderPlaceTime'] = payload['orderPlaceTime']
        ..fields['orderPlaceDate'] = payload['orderPlaceDate']
        ..fields['vehicleType'] = payload['vehicleType'];

      request.files.add(await http.MultipartFile.fromPath(
        'userAuthenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      // Add the token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add custom headers if any
      if (customHeaders != null) {
        request.headers.addAll(customHeaders);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        debugPrint('Failed to update profile: ${response.reasonPhrase}');
        debugPrint('Response body: ${response.body}');
        return {"message": "Failed to update profile"};
      }
    } catch (e) {
      debugPrint("$e");
      if (e is DioError) {
        if (e.response?.statusCode == 404) {
          return e.response?.data;
        } else if (e.response?.statusCode == 401) {
          return e.response?.data;
        } else if (e.response?.statusCode == 400) {
          return e.response?.data;
        } else {
          return {"message": "Something went wrong!"};
        }
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////
  // Future postRequestUserBookFormData({
  //   required File image,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   //   //   'first_name': payload['firstName'],
  //   //   //   'last_name': payload['lastName'],
  //   try {
  //     var request = http.MultipartRequest('POST', url)

  //       ..fields['dropLangitude'] = payload['dropLangitude']
  //       ..fields['dropLongitude'] = payload['dropLongitude']
  //       ..fields['pickupLangitude'] = payload['pickupLangitude']
  //       ..fields['pickupLongitude'] = payload['pickupLongitude']
  //       ..fields['pickupAddress'] = payload['pickupAddress']
  //       ..fields['dropAddress'] = payload['dropAddress']
  //       ..fields['price'] = payload['price']
  //       ..fields['orderPlaceTime'] = payload['orderPlaceTime']
  //       ..fields['orderPlaceDate'] = payload['orderPlaceDate']
  //       ..fields['vehicleType'] = payload['vehicleType'];

  //     request.files.add(await http.MultipartFile.fromPath(
  //       'userAuthenticationImage',
  //       image.path,
  //       contentType: MediaType('image', 'png'), // or other image type
  //     ));

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     }
  //     // else {
  //     //   print('Failed to update profile: ${response.reasonPhrase}');
  //     //   print('Response body: ${response.body}');
  //     // }
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //     // var header = {
  //     //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
  //     // };
  //     // var response = await http.patch(url, headers: header, body: payload);
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  ///

  //]

  //

  //////////
  //  var request = http.MultipartRequest('PATCH', url)
  //     ..headers['Authorization'] = 'Bearer $authToken'
  //     ..fields['first_name'] = firstName
  //     ..fields['last_name'] = lastName;

  //   // Add the profile picture file
  //   if (profilePic != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'profile_pic',
  //       profilePic.path,
  //       contentType: MediaType('image', 'jpeg'), // or other image type
  //     ));
  //   }

  //   // Send the request
  //   var response = await request.send();
  ////////

  Future postRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// DonorRegister
  Future postRequestDonorRegister({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = '*/*';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // Postno Token

  Future<Map<String, dynamic>> postRequestNotoken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint
        // "http://womenrapido.nuhvin.com/auth/send-otp"
        ); // Replace with your baseUrl + endpoint if needed

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(payload),
      );

      // Handle 301 status code
      if (response.statusCode == 301 || response.statusCode == 302) {
        String? newUrl = response.headers['location'];
        if (newUrl != null) {
          url = Uri.parse(newUrl);
          response = await http.post(
            url,
            headers: headers,
            body: json.encode(payload),
          );
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return handleError(response);
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

  Map<String, dynamic> handleError(http.Response response) {
    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      return {"message": "Something went wrong!"};
    }
  }

//   import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

  // Future<Map<String, dynamic>> postRequestNotoken({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(
  //       "http://womenrapido.nuhvin.com/auth/send-otp/"); // Replace with your baseUrl + endpoint if needed

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   if (customHeaders != null) {
  //     headers.addAll(customHeaders);
  //   }

  //   try {
  //     var response = await http.post(
  //       url,
  //       headers: headers,
  //       body: json.encode(payload),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return json.decode(response.body);
  //     } else {
  //       return handleError(response);
  //     }
  //   } catch (e) {
  //     debugPrint("$e");
  //     return {"message": "Something went wrong!"};
  //   }
  // }

  // Map<String, dynamic> handleError(http.Response response) {
  //   if (response.statusCode == 404 ||
  //       response.statusCode == 401 ||
  //       response.statusCode == 400) {
  //     return json.decode(response.body);
  //   } else {
  //     return {"message": "Something went wrong!"};
  //   }
  // }

  Future postRequestNotokentwo({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //PostToken
  Future postRequestToken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.post("$url",
          //  "https://blood-server-us7o.onrender.com/auth/registor/donor",
          data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////////////Verify Docs

  //PostToken
  // Future postRequestTokenVerifyDocs({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(VerificationUrl + endpoint);
  //   try {
  //     Dio dio = Dio();
  //     dio.options.headers["content-type"] = 'application/json';
  //     dio.options.headers["accept"] = 'application/json';
  //     dio.options.headers["x-auth-key"] = "q4Ewu5OELeimuoiS";

  //     var response = await dio.post("$url",
  //         //  "https://blood-server-us7o.onrender.com/auth/registor/donor",
  //         data: payload);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  // Post patch

  // Future patchRequestEditProfile({
  //   required File profilePic,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   try {

  //   //   Dio dio = Dio();

  //   //   dio.options.headers["content-type"] = 'application/json';
  //   //   dio.options.headers["accept"] = 'application/json';
  //   //   String fileName = profilePic.path.split('/').last;

  //   // FormData formData = FormData.fromMap({
  //   //   "profile_image": await MultipartFile.fromFile(
  //   //     file.path,
  //   //     filename: fileName,
  //   //   ),
  //   // });
  //   // //   FormData formData = FormData.fromMap({
  //   //   'first_name': payload['firstName'],
  //   //   'last_name': payload['lastName'],
  //   //   'image': await MultipartFile.fromBytes(
  //   //     'image', // Field name
  //   //     profilePic.readAsBytes(),
  //   //     filename: fileName, // Specify the filename
  //   //     contentType: MediaType('image', 'jpg'), // Set the content type
  //   //   ),
  //   // });
  //     // FormData formData = FormData();
  //     // formData.fields
  //     //   ..add(MapEntry('first_name', payload["firstName"]))
  //     //   ..add(MapEntry('last_name', payload["lastName"]));
  //     // formData.files.add(MapEntry(
  //     //   'image',
  //     //   await MultipartFile.fromFile(profilePic.path, filename: fileName),
  //     // )
  //     // );

  //    // var response = await dio.patch("$url", data: payload);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }
  // ///////////////////

  //     FormData formData = FormData();
  //     formData.fields
  //       ..add(MapEntry('first_name', firstName))
  //       ..add(MapEntry('last_name', lastName));
  //     formData.files.add(MapEntry(
  //       'profile_pic',
  //       await MultipartFile.fromFile(profilePic.path, filename: fileName),
  //     ));

  //     Response response = await _dio.patch('/users/$userId', data: formData);

  // ////////////
  Future patchRequestList({
    required String endpoint,
    required List payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //

  Future patchRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.patch("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //pastch no tokrn
  Future patchRequestNoToken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';

      var response = await dio.patch("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // PatchRequestNo Payload
  Future patchRequestNopayload({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.patch("$url");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // post like
  Future postlikeRequest({
    required String endpoint,
    //  required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future deleteRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.delete("$url");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future<dynamic> postAuthRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var response = await http.post(url, body: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else if (response.statusCode == 404) {
        return response.body;
      } else if (response.statusCode == 401) {
        return response.body;
      } else if (response.statusCode == 400) {
        return response.body;
      } else if (response.statusCode == 500) {
        return response.body;
      } else {
        return {"message": "Something went wrong!"};
      }
    } on DioError catch (e) {
      debugPrint("$e");
      return {"message": "$e"};
    }
  }

  // posr save logo 2
  ///
  Future<dynamic> postAuthRequestSavelogo2Raw({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);

    // Default headers
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    try {
      // JSON encode the payload
      String body = json.encode(payload);

      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        // Handle error responses
        return response.body;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return json.encode({"message": "Something went wrong: $e"});
    }
  }

//////////////////////////
  // Future<dynamic> postAuthRequestSavelogo2Raw({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(dummybaseUrl2 + endpoint);
  //   Map<String, String> headers = {'Content-Type': 'application/json'};
  //   try {
  //     var response = await http.post(url, body: payload, headers: headers);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     } else if (response.statusCode == 404) {
  //       return response.body;
  //     } else if (response.statusCode == 401) {
  //       return response.body;
  //     } else if (response.statusCode == 400) {
  //       return response.body;
  //     } else if (response.statusCode == 500) {
  //       return response.body;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     return {"message": "$e"};
  //   }
  // }
  //

  //

// Get Token
/////////////////////////////////////////////////////////////////////////////////

  Future<dynamic> getter({
    required String endpoint,
  }) async {
    Uri url = Uri.parse(
        baseUrl + endpoint); // Replace with your baseUrl + endpoint if needed

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSimplePreferences.getToken()}'
    };

    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      // Handle 301 status code
      if (response.statusCode == 301 || response.statusCode == 302) {
        String? newUrl = response.headers['location'];
        if (newUrl != null) {
          url = Uri.parse(newUrl);
          response = await http.get(
            url,
            headers: headers,
          );
        }
      }

      //    if (response.statusCode == 200) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
        // return json.decode(response.body);
      } else {
        return handleGetError(response);
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

  Map<String, dynamic> handleGetError(http.Response response) {
    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      return {"message": "Something went wrong!"};
    }
  }

//////////////////////////////////////////////

  // GetNoToken
  Future<dynamic> getRequestNoToken({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var response = await http.get(url);
      // var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  // GetNoToken
  Future<dynamic> getRequestNoTokendummy({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(dummybaseUrl2 + endpoint);
    try {
      var response = await http.get(url);
      // var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future<dynamic> postreportRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
    required Map<dynamic, dynamic> payload,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var response = await http.post(url, body: payload, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static updateProfilePhoto(File file) {}
  Future<dynamic> putForProfileUpdateRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
    File? image,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var headers = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var request = http.MultipartRequest('PUT', Uri.parse(baseUrl + endpoint));
      request.fields.addAll({
        'full_name': payload["full_name"],
        'phone': payload["phone"],
        'gender': payload["gender"],
        'constituency': payload["constituency"]
      });
      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return {"status": "Updated"};
      } else {
        return ({"message": response.reasonPhrase});
      }
    } on DioError catch (e) {
      return {"message": "$e"};
    }
  }

  Future<dynamic> postReportRequest(
      {required String endpoint,
      required Map<dynamic, dynamic> payload,
      Map<String, String>? customHeaders,
      File? problem,
      File? salefe}) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var headers = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint));
      request.fields.addAll({
        'full_name': payload["full_name"],
        'email': payload["email"],
        'mobile_no': payload["mobile_no"],
        'pincode': payload["pincode"],
        'city': payload["city"],
        'state': payload["state"],
        'address': payload["address"],
        'report': payload["report"],
      });
      if (problem != null) {
        request.files.add(
            await http.MultipartFile.fromPath('report_image', problem.path));
      }
      if (salefe != null) {
        request.files.add(
            await http.MultipartFile.fromPath('reporter_selfie', salefe.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return {"status": "Updated"};
      } else {
        return ({"message": response.reasonPhrase});
      }
    } on DioError catch (e) {
      return {"message": "$e"};
    }
  }

  Future<dynamic> postToolRazorpay({
    required String endpoint,
    required payload,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        'tool_id': payload["tool_id"],
        'user_id': payload["user_id"],
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response body
        String responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        return {"message": response.reasonPhrase};
      }
    } catch (e) {
      return {"message": "Error: $e"};
    }
  }
  //
  // Future<dynamic> postToolRazorpay({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   try {
  //     var request =
  //         http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint));
  //     request.fields.addAll(
  //         {'tool_id': payload["tool_id"], 'user_id': payload["user_id"]});

  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response;
  //       // return {"status": "Updated"};
  //     } else {
  //       return ({"message": response.reasonPhrase});
  //     }
  //   } on DioError catch (e) {
  //     return {"message": "$e"};
  //   }
  // }
}
