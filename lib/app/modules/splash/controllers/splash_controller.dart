// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/api-list.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/config_model.dart';
import '../../../data/model/response/country_code.dart';
import '../../../data/model/response/language_model.dart';

class SplashController extends GetxController {
  static Server server = Server();
  final box = GetStorage();
  ConfigData configData = ConfigData();
  CountryInfoData countryInfoData = CountryInfoData();
  ConfigModel configModel = ConfigModel();
  CountryInfo countryInfo = CountryInfo();
  bool loader = false;

  LanguageModel languageModelData = LanguageModel();
  LanguageData languageData = LanguageData();
  List<LanguageData> languageDataList = <LanguageData>[];

  @override
  void onInit() {
    getConfiguration();
    getLanguageData();
    super.onInit();
  }

  Future<ConfigModel?> getConfiguration() async {
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.configuration)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          configModel = ConfigModel.fromJson(jsonResponse);
          configData = configModel.data!;
          update();
          getCountryInfo(configModel.data!.companyCountryCode.toString());
          update();
          return configModel;
        } else {
          debugPrint(response.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return configModel;
  }

  Future<CountryInfo?> getCountryInfo(String countryCode) async {
    final box = GetStorage();
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.countryInfo! + countryCode)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          countryInfo = CountryInfo.fromJson(jsonResponse);
          countryInfoData = countryInfo.data!;
          update();
          box.write("countryCode", countryInfoData.callingCode);
          box.write("countryFlag", countryInfoData.flagEmoji);
          update();
          return countryInfo;
        } else {
          debugPrint(response.body);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return countryInfo;
  }

  Future<LanguageModel> getLanguage() async {
    try {
      await server
          .getRequestWithoutToken(endPoint: APIList.language!)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          languageModelData = LanguageModel.fromJson(jsonResponse);
          return languageData;
        }
      });
      return languageModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return languageModelData;
  }

  getLanguageData() async {
    var langData = await getLanguage();
    if (langData.data!.isNotEmpty) {
      languageDataList = langData.data!;
      update();
    }
  }
}
