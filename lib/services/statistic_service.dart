import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/statistic/certificate_statistic.dart';
import 'package:xiaoming/models/statistic/krob_khan_statistic.dart';
import 'package:xiaoming/models/statistic/merit_statistic.dart';
import 'package:xiaoming/models/statistic/skill_by_degree_statistic.dart';
import 'package:xiaoming/models/statistic/staff_statistic.dart';
import 'package:xiaoming/models/statistic/result_organization.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'dart:math' as math;
import 'package:xiaoming/views/statistic/statistics_page.dart';

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

  Future<List<ChartModel>?> getSkillByDegree(
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
        final skillByDegreeStatistic =
            skillByDegreeStatisticFromMap(response.body);

        final List<ChartModel> certificateData = [];
        skillByDegreeStatistic.forEach((e) {
          certificateData.add(
            ChartModel(
              e.categoryName,
              e.total.toDouble(),
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

  Future<List<ChartModel>?> getSkills(
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
        "${api_url.statSkills}?"
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
        final skillStatistic = skillByDegreeStatisticFromMap(response.body);

        final List<ChartModel> certificateData = [];
        skillStatistic.forEach((e) {
          certificateData.add(
            ChartModel(
              e.categoryName,
              e.total.toDouble(),
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

  Future<List<ChartModel>?> getCertificates(
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

        final List<ChartModel> certificateData = [];
        certificateStatistic.forEach((e) {
          certificateData.add(
            ChartModel(
              degreesTranslation[e.certName] ?? "",
              e.total.toDouble(),
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

  Future<List<ChartModel>?> getStaffCount(
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

        final List<ChartModel> staffData = [];

        final femaleAmount = double.parse(genderStatistic.female);
        final maleAmount = double.parse(genderStatistic.total) - femaleAmount;

        staffData.add(ChartModel("ប្រុស", maleAmount, Colors.green));
        staffData
            .add(ChartModel("ស្រី", femaleAmount, Colors.deepPurpleAccent));
        return staffData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<ChartModel>?> getMerits(
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
          "${api_url.statMerit}?MinistryCode=$ministryCode&Org=$org&Dept=$dept");
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final meritStatistic = meritStatisticFromMap(response.body);

        final List<ChartModel> certificateData = [];
        meritStatistic.forEach((e) {
          certificateData.add(
            ChartModel(
              e.meritKh,
              double.parse(e.count),
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

  Future<List<ChartModel>?> getKrobKhans(
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
        "${api_url.statKrobKhan}?"
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
        final krobKhanStatistic = krobKhanStatisticFromMap(response.body);

        final List<ChartModel> krobKhanData = [];
        krobKhanData.add(
          ChartModel(
            "ក",
            double.parse(krobKhanStatistic.a),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
        );
        krobKhanData.add(
          ChartModel(
            "ខ",
            double.parse(krobKhanStatistic.b),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
        );
        krobKhanData.add(
          ChartModel(
            "គ",
            double.parse(krobKhanStatistic.c),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
        );
        krobKhanData.add(
          ChartModel(
            "គ្មាន",
            double.parse(krobKhanStatistic.noKrobkhan),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
        );
        krobKhanData.add(
          ChartModel(
            "ចូលនិវត្តន៍",
            double.parse(krobKhanStatistic.retire),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
        );
        return krobKhanData;
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
  final List<String> krobKhans = [
    "ទាំងអស់",
    "ក",
    "ខ",
    "គ",
    "គ្មាន",
    "ចូលនិវត្តន៍",
  ];
}
