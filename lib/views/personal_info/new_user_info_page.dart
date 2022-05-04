import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/views/personal_info/additional_position_info_page.dart';
import 'package:xiaoming/views/personal_info/education_history_info_page.dart';
import 'package:xiaoming/views/personal_info/family_history_info_page.dart';
import 'package:xiaoming/views/personal_info/krob_khan_info_page.dart';
import 'package:xiaoming/views/personal_info/language_info_page.dart';
import 'package:xiaoming/views/personal_info/merit_info_page.dart';
import 'package:xiaoming/views/personal_info/personal_info_page.dart';
import 'package:xiaoming/views/personal_info/work_history_info_page.dart';

class NewUserInfoPage extends StatefulWidget {
  const NewUserInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewUserInfoPage> createState() => _NewUserInfoPageState();
}

class _NewUserInfoPageState extends State<NewUserInfoPage>
    with TickerProviderStateMixin {
  final List<String> tabsTitle = [
    "ព័ត៌មានផ្ទាល់ខ្លួន",
    "ក្របខណ្ឌ",
    "មុខងារបន្ថែម",
    "គ្រឿងឥស្សរិយយស",
    "ប្រវត្តិការងារ",
    "ប្រវត្តិការសិក្សា",
    "ភាសា",
    "ព័តមានគ្រួសារ",
  ];

  final List<Widget> personalInfoViews = const [
    PersonalInfoPage(),
    KrobKhanInfoTable(),
    AdditionalPositionInfoTable(),
    MeritInfoTable(),
    WorkHistoryInfoTable(),
    EducationHistoryInfoTable(),
    LanguageInfoTable(),
    FamilyHistoryInfoTable(),
  ];

  late final tabController = TabController(
    length: tabsTitle.length,
    vsync: this,
  );

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {
      final List<int> visibleIndexes = itemPositionsListener.itemPositions.value
          .map((e) => e.index)
          .toList();
      visibleIndexes.sort((a, b) => a.compareTo(b));
      setState(() {
        if (visibleIndexes.length != 0) {
          changeTabBarPosition(visibleIndexes[0]);
        }
      });
    });
  }

  void changeTabBarPosition(int index) {
    tabController.animateTo(index);
  }

  void onClickTabBar(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                bottom: (GetPlatform.isIOS) ? false : true,
                left: false,
                right: false,
                sliver: SliverAppBar(
                  title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
                  floating: true,
                  pinned: true,
                  snap: false,
                  primary: true,
                  stretch: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    controller: tabController,
                    tabs: [
                      ...tabsTitle.map((e) {
                        return InkWell(
                          onTap: () {
                            onClickTabBar(tabsTitle.indexOf(e));
                          },
                          child: Tab(
                            text: e,
                          ),
                        );
                      })
                    ],
                    isScrollable: true,
                    indicatorColor: CompanyColors.yellow,
                    indicatorWeight: 3,
                  ),
                ),
              ),
            ),
          ];
        },
        body: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          shrinkWrap: true,
          itemCount: personalInfoViews.length,
          itemBuilder: (context, index) {
            return personalInfoViews[index];
          },
        ),
      ),
    );
  }

  Widget fillerList() {
    return ListView(
      children: <Widget>[
        for (int i = 0; i < 10; i++)
          SizedBox(
            height: 30,
            child: Text(
              "Conten at 0 -" + i.toString(),
            ),
          ),
        for (int i = 0; i < 10; i++)
          SizedBox(height: 30, child: Text("Conten at 1 -" + i.toString())),
        for (int i = 0; i < 10; i++)
          SizedBox(height: 30, child: Text("Conten at 2 -" + i.toString())),
        for (int i = 0; i < 10; i++)
          SizedBox(height: 30, child: Text("Conten at 3 -" + i.toString())),
        for (int i = 0; i < 10; i++)
          SizedBox(height: 30, child: Text("Conten at 4 -" + i.toString())),
      ],
    );
  }
}
