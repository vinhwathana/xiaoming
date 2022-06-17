import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/views/request_leave/add_request_leave.dart';

import '../../colors/company_colors.dart';

class RequestLeavePage extends StatefulWidget {
  const RequestLeavePage({Key? key}) : super(key: key);

  @override
  State<RequestLeavePage> createState() => _RequestLeavePageState();
}

class _RequestLeavePageState extends State<RequestLeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ការស្នើសុំច្បាប់"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 2,
        itemBuilder: (context, index) {
          return RequestLeaveCard();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddRequestLeavePage());
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class RequestLeaveCard extends StatelessWidget {
  const RequestLeaveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shadowColor: Colors.orange,
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
                      "តិចជាង៥ថ្ងៃ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "26-05-2022 10:41:44",
                      style: const TextStyle(
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    Text(
                      "ចំនួនថ្ងៃ: ៥",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "ស្ថានភាព: ",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "កំពុងរង់ចាំ",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
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
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("ចាប់ពីថ្ងៃទី"),
                            Text("01-05-2022"),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("ចាប់ពីថ្ងៃទី"),
                            Text("01-05-2022"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
