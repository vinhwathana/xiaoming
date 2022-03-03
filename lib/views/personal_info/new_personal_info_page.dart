import 'package:flutter/material.dart';
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

class NewPersonalInfoPage extends StatefulWidget {
  const NewPersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<NewPersonalInfoPage> createState() => _NewPersonalInfoPageState();
}

class _NewPersonalInfoPageState extends State<NewPersonalInfoPage>
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

  final List<Widget> personalInfoViews = [
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
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
                            tabController.animateTo(tabsTitle.indexOf(e));
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
        body: ScrollablePositionedList.separated(
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 3,
              color: CompanyColors.yellow,
            );
          },
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

class ScrollChangeTabBar extends StatefulWidget {
  const ScrollChangeTabBar({
    Key? key,
  }) : super(key: key);

  @override
  _ScrollChangeTabBarState createState() => _ScrollChangeTabBarState();
}

class _ScrollChangeTabBarState extends State<ScrollChangeTabBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                Container(
                  padding: EdgeInsets.all(8),
                  // width: 100,
                  color: CompanyColors.blue,
                  child: Tab(
                    child: Text(
                      "Tab " + i.toString(),
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            // controller: _scrollController,
            children: <Widget>[
              for (int i = 0; i < 10; i++)
                SizedBox(
                  height: 30,
                  child: Text(
                    "Conten at 0 -" + i.toString(),
                  ),
                ),
              for (int i = 0; i < 100; i++)
                SizedBox(
                    height: 30, child: Text("Conten at 1 -" + i.toString())),
              for (int i = 0; i < 100; i++)
                SizedBox(
                    height: 30, child: Text("Conten at 2 -" + i.toString())),
              for (int i = 0; i < 100; i++)
                SizedBox(
                    height: 30, child: Text("Conten at 3 -" + i.toString())),
              for (int i = 0; i < 100; i++)
                SizedBox(
                    height: 30, child: Text("Conten at 4 -" + i.toString())),
            ],
          ),
        ),
      ],
    );
  }
}
