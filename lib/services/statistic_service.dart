import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/statistic/certificate_statistic.dart';
import 'package:xiaoming/models/statistic/staff_statistic.dart';
import 'package:xiaoming/models/statistic/result_organization.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/views/statistic/certificate_statistic_page.dart';
import 'dart:math' as math;

import 'package:xiaoming/views/statistic/chart_page.dart';
import 'package:xiaoming/views/statistic/staff_statistic_page.dart';

class StatisticService {
  final authController = Get.find<AuthenticationController>();

  Future<List<Datum>?> getOrganization({
    String search = "",
    String parentId = "00",
    required String orgRegion,
  }) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    if (orgRegion == "00") {
      return [];
    }
    final String ministryCode = authController.getUserMinistryCode() ?? "00";

    final String start = "0";
    final String length = "50";
    final String orgType = "${orgRegion.substring(0, 3)}001";
    try {
      final uri = Uri.parse(
        "${api_url.getOrganization}?start=$start"
        "&length=$length"
        "&search=$search"
        "&ministry=$ministryCode"
        "&parentId=$parentId"
        "&orgRegion=$orgRegion"
        "&orgType=$orgType",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final resultOrganizations = resultOrganizationFromMap(response.body);
        // final List<String> organizations = [];
        // resultOrganizations.data.forEach((element) {
        //   organizations.add(element.displayText);
        // });
        return resultOrganizations.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Datum>?> getDepartment({
    String search = "",
    required String parentId,
    required String orgRegion,
  }) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    final String ministryCode = authController.getUserMinistryCode() ?? "00";

    final String start = "0";
    final String length = "50";
    final String orgType = "${orgRegion.substring(0, 3)}002";
    try {
      final uri = Uri.parse("${api_url.getOrganization}?start=$start"
          "&length=$length"
          "&search=$search"
          "&ministry=$ministryCode"
          "&parentId=$parentId"
          "&orgRegion=$orgRegion"
          "&orgType=$orgType");
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final resultOrganizations = resultOrganizationFromMap(response.body);
        return resultOrganizations.data;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<CertificateData>?> getCertificates(
    String org,
    String dept,
  ) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    final String? ministryCode = authController.getUserMinistryCode();
    if (ministryCode == null) {
      return null;
    }

    try {
      final uri = Uri.parse(
          "${api_url.statCertificate}?MinistryCode=$ministryCode&Org=$org&Dept=$dept");
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final certificateStatistic = certificateStatisticFromMap(response.body);

        final List<CertificateData> certificateData = [];
        certificateStatistic.forEach((e) {
          certificateData.add(
            CertificateData(
              degreesTranslation[e.certName] ?? "",
              e.total,
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
            ),
          );
        });
        return certificateData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<CertificateData>?> getSkillByDegree(
    String org,
    String dept,
    String degree,
  ) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    final String? ministryCode = authController.getUserMinistryCode();
    if (ministryCode == null) {
      return null;
    }

    try {
      final uri = Uri.parse(
        "${api_url.statSkillByDegree}?"
        "MinistryCode=$ministryCode"
        "&Org=$org"
        "&Dept=$dept"
        "&degree=$degree",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final certificateStatistic = certificateStatisticFromMap(response.body);

        final List<CertificateData> certificateData = [];
        certificateStatistic.forEach((e) {
          certificateData.add(
            CertificateData(
              degreesTranslation[e.certName] ?? "",
              e.total,
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
            ),
          );
        });
        return certificateData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<StaffData>?> getStaffCount(
    String org,
    String dept,
  ) async {
    if (authController.accessToken == null ||
        authController.accessToken!.isEmpty) {
      return null;
    }
    final String? ministryCode = authController.getUserMinistryCode();
    if (ministryCode == null) {
      return null;
    }

    try {
      final uri = Uri.parse(
        "${api_url.statStaff}?"
        "MinistryCode=$ministryCode"
        "&Org=$org"
        "&Dept=$dept",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final genderStatistic = staffStatisticFromMap(response.body);

        final List<StaffData> staffData = [];

        final femaleAmount = int.parse(genderStatistic.female);
        final maleAmount = int.parse(genderStatistic.total) - femaleAmount;

        staffData.add(StaffData("ប្រុស", maleAmount, Colors.green));
        staffData.add(StaffData("ស្រី", femaleAmount, Colors.deepPurpleAccent));
        return staffData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  final Map<String, String> degreesTranslation = {
    "phd": "បណ្ឌិត",
    "master": "អនុបណ្ឌិត",
    "bachelor": "បរិញ្ញាបត្រ",
    "under_bachelor": "បរិញ្ញាបត្ររង",
    "engineer": "វិស្វករ",
  };
}
