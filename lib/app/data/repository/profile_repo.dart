import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/page_model.dart';
import '../model/response/profile_model.dart';

class ProfileRepo {
  static Server server = Server();
  static ProfileModel profileModelData = ProfileModel();
  static PageModel pageModelData = PageModel();

  static Future<ProfileModel?> getProfile() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.profile,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          profileModelData = ProfileModel.fromJson(jsonResponse);
          return profileModelData;
        }
      });
      return profileModelData;
    } catch (e) {
      return null;
    }
  }

  static Future<PageModel> getPages() async {
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.pages!)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          pageModelData = PageModel.fromJson(jsonResponse);
          return pageModelData;
        }
      });
      return pageModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return pageModelData;
  }
}
