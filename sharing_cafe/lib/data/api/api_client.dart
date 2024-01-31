import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';

// import 'package:sixam_mart/data/model/response/address_model.dart';
// import 'package:sixam_mart/data/model/response/error_response.dart';
// import 'package:sixam_mart/data/model/response/module_model.dart';
// import 'package:sixam_mart/helper/responsive_helper.dart';
// import 'package:sixam_mart/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sharing_cafe/data/model/response/error_response.dart';
import 'package:sharing_cafe/helper/responsive_helper.dart';
import 'package:sharing_cafe/util/app_constants.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage = 'connection_to_api_server_failed';
  final int timeoutInSeconds = 40;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    if (kDebugMode) {
      print('Token: $token');
    }

    // ĐOẠN NÀY KIỂM TRA CÓ THỰC THỂ addressModel CHƯA ĐỂ LẤY userAddress/////////////////////////////////////
    // AddressModel? addressModel;
    // try {
    //   addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
    // }catch(_) {}

    // ĐOẠN NÀY KIỂM TRA CÓ THỰC THỂ moduleID CHƯA ĐỂ LẤY moduleId///////////////////////////////////////////
    // int? moduleID;
    // if(GetPlatform.isWeb && sharedPreferences.containsKey(AppConstants.moduleId)) {
    //   try {
    //     moduleID = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!)).id;
    //   }catch(_) {}
    // }

    // HEADER ĐƯỢC SỬA TRONG updateHeader() CỦA NGƯỜI TA YÊU CẦU KHÁC PHẢI VIẾT LẠI////////////////////////////////////////////////////////
    // updateHeader(
    //   token, addressModel?.zoneIds, addressModel?.areaIds,
    //   sharedPreferences.getString(AppConstants.languageCode), moduleID, addressModel?.latitude,
    //     addressModel?.longitude
    // );
  }

  Map<String, String> updateHeader(String? token, {bool setHeader = true}) {
    Map<String, String> header = {};
    header.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    if(setHeader) {
      _mainHeaders = header;
    }
    return header;
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.get(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print('------------${e.toString()}');
      }
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers, int? timeout}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response response = await http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key, multipart.file!.readAsBytes().asStream(), list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response response = await http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    }catch(_) {}
    Response response0 = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(response0.statusCode != 200 && response0.body != null && response0.body is !String) {
      if(response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: errorResponse.errors![0].message);
      }else if(response0.body.toString().startsWith('{message')) {
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: response0.body['message']);
      }
    }else if(response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(kDebugMode) {
      print('====> API Response: [${response0.statusCode}] $uri');
      if(!ResponsiveHelper.isWeb() || response.statusCode != 500){
        print('${response0.body}');
      }
    }
    return response0;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}