import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/screen/chart/android/mobile/ChartAndroidMobile.dart';
import 'package:foody/screen/foods/android/mobile/FoodsAndroidMobile.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class DashboardAndroidMobilePortrait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashBoardAndroidMobilePortraitState();
}

class _DashBoardAndroidMobilePortraitState extends State<DashboardAndroidMobilePortrait>  with TickerProviderStateMixin{

  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2 , initialIndex: 0 , vsync: this);
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }




  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              centerTitle: false,
              title: AutoSizeText(
                  AppLocalizations.of(context)!.translate('dashboard_title'),
                  style: Theme.of(context).textTheme.headline4!.copyWith(),
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
              ),
              bottom: TabBar(
                controller: tabController,
                labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w700),
                // indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).dividerColor,
                isScrollable: false,
                indicator: MD2Indicator(
                  indicatorHeight: 2,
                  indicatorSize: MD2IndicatorSize.tiny,
                  indicatorColor: Theme.of(context).primaryColor,
                ),
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.translate('food_title'),
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.translate('chart_title'),
                  )
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [

                //////////////////////// * Foods * ////////////////////////
                FoodsAndroidMobile(),


                //////////////////////// * Charts * ////////////////////////
                ChartAndroidMobile()

              ],
            )
        ),
      ),
    );
  }
}

//Container(
//             color: Theme.of(context).scaffoldBackgroundColor,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 12 , vertical: 16),
//               physics: ClampingScrollPhysics(),  //BouncingScrollPhysics , NeverScrollableScrollPhysics
//               scrollDirection: Axis.vertical,
//               keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//               child: Column(
//                 children: [
//
//                 ],
//               ),
//             ),
//           ),