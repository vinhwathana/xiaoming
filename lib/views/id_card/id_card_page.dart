import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/custom_future_builder.dart';
import 'package:xiaoming/models/card/id_card_info.dart';
import 'package:xiaoming/services/card_service.dart';

class IdCardPage extends StatefulWidget {
  const IdCardPage({Key? key}) : super(key: key);

  @override
  State<IdCardPage> createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
  final cardDir = "assets/images/card";
  final mptcMoul = "KhmerMPTCMoul";
  final khmerMptc = "KhmerMPTC";
  final khmerOSSiemReap = "KhmerOSSiemReap";
  final niDASowannaphum = 'NiDASowannaphum';
  final niDAFunan = 'NiDAFunan';
  final groundControl = "GroundControl";
  final defaultTextStyle = TextStyle(
    fontFamily: "KhmerMPTC",
    fontSize: (Get.width > 400) ? 17 : 15,
    color: CompanyColors.blue,
    fontWeight: FontWeight.bold,
    height: 1.6,
  );

  bool isVisible = false;

  final flipCardController = FlipCardController();
  final cardService = CardService();
  IdCardInfo? cardInfo;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Device Height: ${Get.height}");
    // print("Device Width: ${Get.width}");
    //Pixel 3XL and 4XL : 411, 797.71 / 820
    //Nexus: 360, 592.0

    return Scaffold(
      appBar: AppBar(
        title: const Text("ប័ណ្ណសម្គាល់ផ្ទាល់ខ្លួន"),
        actions: [
          IconButton(
            onPressed: () {
              flipCardController.toggleCard();
            },
            icon: const Icon(Icons.flip),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          alignment: Alignment.topCenter,
          child: Builder(
            builder: (context) {
              final deviceWidth = Get.width;
              // final deviceHeight = Get.height;

              double width = 330;
              double height = 508;

              double paddingFront = 155;
              double paddingBack = 32;

              if (deviceWidth > 400) {
                width = 375;
                height = 592;
                paddingFront = 190;
                paddingBack = 45;
              }

              return CustomFutureBuilder<IdCardInfo?>(
                future: cardService.getCardInfo(),
                onDataRetrieved: (context, result, connectionState) {
                  cardInfo = result;
                  return FlipCard(
                    controller: flipCardController,
                    flipOnTouch: true,
                    speed: 400,
                    front: cardFront(width, height, paddingFront),
                    back: cardBack(width, height, paddingBack),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget cardBack(double width, double height, padding) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(top: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: width / 2.8,
                  width: width / 2.8,
                  child: Image.memory(
                    base64Decode(cardInfo?.getQrCode ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isVisible,
            child: SizedBox(
              width: width,
              height: height,
              child: Image.asset(
                '$cardDir/background_back_text.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            visible: !isVisible,
            child: SizedBox(
              width: width,
              height: height,
              child: Image.asset(
                '$cardDir/background_back.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(top: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: width / 3.2,
                  width: width / 3.2,
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: (Get.width > 400) ? 105 : 90,
                      ),
                      Text(
                        "ថ្ងៃសុក្រ ១៥រោច ខែផល្គុន ឆ្នាំឆ្លូវ ត្រីស័ក ព.ស.២៥៦៥"
                        "\nរាជធានីភ្នំពេញ ថ្ងៃទី១ ខែមេសា ឆ្នាំ២០២២",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.9,
                          fontSize: 10.2,
                          fontFamily: khmerMptc,
                          color: CompanyColors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: (Get.width > 400) ? 100 : 75,
                          top: (Get.width > 400) ? 6 : 3,
                        ),
                        child: Text(
                          "រដ្ឋមន្ត្រី",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: niDAFunan,
                            color: CompanyColors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: (Get.width > 400) ? 50 : 35,
                          top: (Get.width > 400) ? 56 : 46,
                        ),
                        child: Text(
                          "ជា វ៉ាន់ដេត",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: niDAFunan,
                            color: CompanyColors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.only(left: 16.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "លេខបណ្ណ/Card No.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 11,
                              fontFamily: khmerMptc,
                              color: CompanyColors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            cardInfo?.cardId ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 11,
                              fontFamily: khmerOSSiemReap,
                              color: CompanyColors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "ផុតសុពលភាព/Expiry Date.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 11,
                              fontFamily: khmerMptc,
                              color: CompanyColors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "31-12-2024",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 11,
                              fontFamily: khmerOSSiemReap,
                              color: CompanyColors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardFront(double width, double height, padding) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(top: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: width / 1.9,
                  width: width / 1.9,
                  child: Image.memory(
                    base64Decode(cardInfo?.getPhoto ?? ""),
                    // fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              '$cardDir/background_front.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(top: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: width / 1.9,
                  width: width / 1.9,
                ),
                Text(
                  cardInfo?.fullNameKh ?? "",
                  style: TextStyle(
                    fontSize: (Get.width > 400) ? 24 : 21,
                    fontFamily: mptcMoul,
                    color: CompanyColors.blue,
                    height: (Get.width > 400) ? 1 : 1.2,
                  ),
                ),
                Text(
                  cardInfo?.fullNameEn ?? "",
                  style: TextStyle(
                    fontSize: (Get.width > 400) ? 26 : 23,
                    fontFamily: groundControl,
                    color: CompanyColors.blue,
                    height: 0.9,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(8, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: CircleAvatar(
                          radius: 2.5,
                          backgroundColor: CompanyColors.yellow,
                        ),
                      );
                    })
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: (cardInfo?.cardType == "TYPE_B")
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              cardInfo?.positionKh ?? "",
                              style: defaultTextStyle,
                            ),
                            Text(
                              cardInfo?.positionEn ?? "",
                              style: defaultTextStyle,
                            ),
                            Text(
                              cardInfo?.unitTitle ?? "",
                              style: defaultTextStyle,
                            ),
                            Text(
                              cardInfo?.unitTitleEn ?? "",
                              style: defaultTextStyle,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cardInfo?.positionKh ?? "",
                              style: TextStyle(
                                fontFamily: mptcMoul,
                                fontSize: 22,
                                color: CompanyColors.blue,
                                height: 1.6,
                              ),
                            ),
                            Text(
                              cardInfo?.positionEn ?? "",
                              style: TextStyle(
                                fontFamily: groundControl,
                                fontSize: 22,
                                color: CompanyColors.blue,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget something(double width, double height) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          color: Colors.black,
          child: Image.asset(
            '$cardDir/background_front.png',
          ),
        )
      ],
    );
  }
}
