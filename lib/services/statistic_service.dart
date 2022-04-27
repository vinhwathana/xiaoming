import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/statistic/number/certificate_statistic.dart';
import 'package:xiaoming/models/statistic/number/krob_khan_statistic.dart';
import 'package:xiaoming/models/statistic/number/merit_statistic.dart';
import 'package:xiaoming/models/statistic/number/result_organization.dart';
import 'package:xiaoming/models/statistic/number/skill_by_degree_statistic.dart';
import 'package:xiaoming/models/statistic/number/staff_statistic.dart';
import 'package:xiaoming/models/statistic/people/statistic_people_response.dart';
import 'package:xiaoming/utils/api_route.dart' as api_url;
import 'package:xiaoming/views/statistic/statistics_page_wrapper.dart';

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

    const String start = "0";
    const String length = "50";
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

    const String start = "0";
    const String length = "50";
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
    return null;
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
        for (var e in skillByDegreeStatistic) {
          certificateData.add(
            ChartModel(
              e.categoryName,
              e.total.toDouble(),
              listColor[skillByDegreeStatistic.indexOf(e)],
            ),
          );
        }
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
        for (var e in skillStatistic) {
          certificateData.add(
            ChartModel(
              e.categoryName,
              e.total.toDouble(),
              listColor[skillStatistic.indexOf(e)],
            ),
          );
        }
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

        final indexOfEngineer = certificateStatistic
            .indexWhere((element) => element.certName == "engineer");
        final indexOfPhD = certificateStatistic
            .indexWhere((element) => element.certName == "phd");
        if (indexOfEngineer != -1 && indexOfPhD != -1) {
          final engineerStat = certificateStatistic[indexOfEngineer];
          certificateStatistic[indexOfPhD].total += engineerStat.total;
          certificateStatistic.removeAt(indexOfEngineer);
        }
        final List<ChartModel> certificateData = [];
        for (var e in certificateStatistic) {
          certificateData.add(
            ChartModel(
              degreesTranslation[e.certName] ?? "",
              e.total.toDouble(),
              listColor[certificateStatistic.indexOf(e)],
            ),
          );
        }
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

        staffData.add(ChartModel("ប្រុស", maleAmount, listColor[0]));
        staffData.add(ChartModel("ស្រី", femaleAmount, listColor[1]));
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

        for (var e in meritStatistic) {
          certificateData.add(
            ChartModel(
              e.meritKh,
              double.parse(e.count),
              listColor[meritStatistic.indexOf(e)],
            ),
          );
        }
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
            listColor[0],
          ),
        );
        krobKhanData.add(
          ChartModel(
            "ខ",
            double.parse(krobKhanStatistic.b),
            listColor[1],
          ),
        );
        krobKhanData.add(
          ChartModel(
            "គ",
            double.parse(krobKhanStatistic.c),
            listColor[2],
          ),
        );
        krobKhanData.add(
          ChartModel(
            "គ្មាន",
            double.parse(krobKhanStatistic.noKrobkhan),
            listColor[3],
          ),
        );
        krobKhanData.add(
          ChartModel(
            "ចូលនិវត្តន៍",
            double.parse(krobKhanStatistic.retire),
            listColor[4],
          ),
        );
        return krobKhanData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<StatisticPeopleResponse?> getCertificatePeople(
    String org,
    String dept,
    String degree, {
    int? start,
    int? length,
    String? search = "",
  }) async {
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
        "${api_url.statCertificatePeople}?"
        "MinistryCode=$ministryCode"
        "&Org=$org"
        "&Dept=$dept"
        "&degree=$degree"
        "&start=$start"
        "&length=$length"
        "&search=$search",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final responseData =
            certificateSkillPeopleStatResponseFromJson(response.body);
        return responseData;
      } else {
        print(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<StatisticPeopleResponse?> getSkillPeople(
    String org,
    String dept,
    String degree, {
    int? start = 0,
    int? length = 0,
    String? search = "",
    String? country = "",
    String? skill = "",
  }) async {
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
        "${api_url.statSkillPeople}?"
        "MinistryCode=$ministryCode"
        "&Org=$org"
        "&Dept=$dept"
        "&degree=$degree"
        "&start=$start"
        "&length=$length"
        "&search=$search"
        "&country=$country"
        "&skill=$skill",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      if (response.statusCode == 200) {
        final responseData =
            certificateSkillPeopleStatResponseFromJson(response.body);
        return responseData;
      } else {
        // print(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<StatisticPeopleResponse?> getSkillByDegreePeople(
    String org,
    String dept,
    String degree, {
    int? start = 0,
    int? length = 0,
    String? search = "",
    String? country = "",
    String? skill = "",
  }) async {
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
        "${api_url.statSkillByDegreePeople}?"
        "MinistryCode=$ministryCode"
        "&Org=$org"
        "&Dept=$dept"
        "&degree=$degree"
        "&start=$start"
        "&length=$length"
        "&search=$search"
        "&country=$country"
        "&skill=$skill",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      log(response.body);

      if (response.statusCode == 200) {
        final responseData =
            certificateSkillPeopleStatResponseFromJson(response.body);
        return responseData;
      } else {
        print(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<StatisticPeopleResponse?> getStaffPeople(
    String org,
    String dept, {
    int? start = 0,
    int? length = 0,
    String? search = "",
    String? country = "",
    String? skill = "",
  }) async {
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
        "${api_url.statStaffPeople}?"
        "MinistryCode=$ministryCode"
        "&Org=$org"
        "&Dept=$dept"
        "&start=$start"
        "&length=$length"
        "&search=$search",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${authController.accessToken!}",
        },
      );

      log(response.body);

      if (response.statusCode == 200) {
        final responseData =
            certificateSkillPeopleStatResponseFromJson(response.body);
        return responseData;
      } else {
        print(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<StatisticPeopleResponse?> getMeritPeople(
      String org,
      String dept, {
        int? start = 0,
        int? length = 0,
        String? search = "",
        String? country = "",
        String? skill = "",
      }) async {
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
        "${api_url.statMeritPeople}?"
            "MinistryCode=$ministryCode"
            "&Org=$org"
            "&Dept=$dept"
            "&start=$start"
            "&length=$length"
            "&search=$search",
      );
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
          "Bearer ${authController.accessToken!}",
        },
      );

      log(response.body);

      if (response.statusCode == 200) {
        final responseData =
        certificateSkillPeopleStatResponseFromJson(response.body);
        return responseData;
      } else {
        print(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  final Map<String, String> degreesTranslation = {
    "phd": "បណ្ឌិត",
    "master": "បរិញ្ញាបត្រជាន់ខ្ពស់",
    "bachelor": "បរិញ្ញាបត្រ",
    "under_bachelor": "បរិញ្ញាបត្ររង",
    "engineer": "វិស្វករ",
  };
  final degrees = [
    "បណ្ឌិត",
    "បរិញ្ញាបត្រជាន់ខ្ពស់",
    "បរិញ្ញាបត្រ",
    "បរិញ្ញាបត្ររង",
  ];
  final List<String> krobKhans = [
    "ទាំងអស់",
    "ក",
    "ខ",
    "គ",
    "គ្មាន",
    "ចូលនិវត្តន៍",
  ];

  final List<Color> listColor = [
    Colors.red,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.amber,
    Colors.blue,
    CompanyColors.blue,
    CompanyColors.red,
    CompanyColors.yellow,
    Colors.blueAccent,
    Colors.deepOrange,
    Colors.cyanAccent,
    Colors.lime,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.white38,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.amber,
    Colors.blue,
    CompanyColors.blue,
    CompanyColors.red,
    CompanyColors.yellow,
    Colors.blueAccent,
    Colors.deepOrange,
    Colors.cyanAccent,
    Colors.lime,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.white38,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.amber,
    Colors.blue,
    CompanyColors.blue,
    CompanyColors.red,
    CompanyColors.yellow,
    Colors.blueAccent,
    Colors.deepOrange,
    Colors.cyanAccent,
    Colors.lime,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.white38,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.amber,
    Colors.blue,
    CompanyColors.blue,
    CompanyColors.red,
    CompanyColors.yellow,
    Colors.blueAccent,
    Colors.deepOrange,
    Colors.cyanAccent,
    Colors.lime,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.white38,
    Colors.black,
  ];
}
