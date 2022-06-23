import 'package:xiaoming/models/dashboard/today_work_period.dart';
import 'package:xiaoming/services/utils.dart';

import '../utils/api_route.dart';

class DashboardService {
  Future<TodayWorkPeriod?> getTodayWorkPeriod() async {
    const String url = todayWorkPeriodUrl;
    final response = await callingApiMethod(url: url, method: Method.GET);
    if (response is Map<String, dynamic>) {
      final todayWorkPeriod = TodayWorkPeriod.fromJson(response);
      return todayWorkPeriod;
    }

    processError(response);
    return null;
  }
}
