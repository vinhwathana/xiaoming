import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/models/request_leave/personal_request_leave_list.dart';
import 'package:xiaoming/services/request_leave_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/request_leave/add_request_leave.dart';

import '../../colors/company_colors.dart';

class RequestLeavePage extends StatefulWidget {
  const RequestLeavePage({Key? key}) : super(key: key);

  @override
  State<RequestLeavePage> createState() => _RequestLeavePageState();
}

class _RequestLeavePageState extends State<RequestLeavePage> {
  final requestLeaveService = RequestLeaveService();

  final format = DateFormat("dd/MM/yyyy hh:mm:ss A");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ការស្នើសុំច្បាប់"),
      ),
      body: CustomFutureBuilder<PersonalRequestLeaveList?>(
        future: requestLeaveService.getPersonalRequestLeave(),
        onDataRetrieved: (context, result, connectionState) {
          final requestLeaveList = result;
          final data = requestLeaveList?.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: requestLeaveList?.totalFilteredRecord ?? 0,
            itemBuilder: (context, index) {
              return RequestLeaveCard(
                requestLeaveData: data[index],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddRequestLeavePage());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class RequestLeaveCard extends StatelessWidget {
  const RequestLeaveCard({
    Key? key,
    this.requestLeaveData,
  }) : super(key: key);

  final RequestLeaveData? requestLeaveData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shadowColor: requestLeaveData?.getColor ?? CompanyColors.yellow,
      elevation: 6,
      child: InkWell(
        onTap: () {},
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(8),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    Text(
                      requestLeaveData?.leaveTypeKh ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatDateForView(requestLeaveData?.getDateCreated()),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: CompanyColors.yellow,
                thickness: 1.5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    Text(
                      "ចំនួនថ្ងៃ: ${requestLeaveData?.days ?? ""}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "ស្ថានភាព: ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          requestLeaveData?.getStatus ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            color: requestLeaveData?.getColor ??
                                CompanyColors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: CompanyColors.yellow,
                thickness: 1.5,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("ចាប់ពីថ្ងៃទី"),
                        Text(formatDateForView(requestLeaveData?.getDateFrom())),
                      ],
                    ),
                    Column(
                      children: [
                        Text("ចាប់ពីថ្ងៃទី"),
                        Text(formatDateForView(requestLeaveData?.getDateTo())),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
