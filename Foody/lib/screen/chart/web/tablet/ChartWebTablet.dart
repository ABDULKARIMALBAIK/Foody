import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:foody/bloc/blocUnit/AnimatedButtonBloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';
import 'package:foody/constant/PurchasesDataSource.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/viewModel/ChartViewModel.dart';
import 'package:foody/widget/DrawerApp.dart';
import 'package:foody/widget/FoodyNavigationRail.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:foody/model/modelFake/ChartBestFoodsModel.dart';
import 'package:foody/model/modelFake/ChartDiscountModel.dart';
import 'package:foody/model/modelFake/ChartForecastingNumOrdersModel.dart';
import 'package:foody/model/modelFake/ChartNumDiscountsFoodsModel.dart';
import 'package:foody/model/modelFake/ChartNumFavEachFoodPerYear.dart';
import 'package:foody/model/modelFake/ChartNumOrderFoodsModel.dart';
import 'package:foody/model/modelFake/ChartPurchasesPerMonthModel.dart';


class ChartWebTablet extends StatelessWidget{


  //Init controllers
  late ScrollController scrollController;
  late DataGridController dataGridController;


  //Init ViewModel
  late ChartViewModel viewModel;

  //vars
  late GlobalKey<ScaffoldState> _scaffoldState;
  var darkMode;


  ChartWebTablet(){

    scrollController = ScrollController();
    viewModel = ChartViewModel();
    dataGridController = DataGridController();

    //Show dataGridSelection
    // int selectedIndex = dataGridController.selectedIndex;
    // DataGridRow selectedRow = dataGridController.selectedRow!;
    // List<DataGridRow> selectedRows = dataGridController.selectedRows;
    // print(selectedIndex);
    // print(selectedRow);
    // print(selectedRows);
  }


  @override
  Widget build(BuildContext context) {

    _scaffoldState = GlobalKey<ScaffoldState>();

    var box = Hive.box('foody');
    darkMode = box.get('darkMode', defaultValue: false);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldState,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height ,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [

              //////////////////////// * Drawer * ////////////////////////
              FoodyNavigationRail(2, context),
              SizedBox(width: 6,),


              //////////////////////// * charts * ////////////////////////
              Expanded(
                  flex: 1,
                  child: CustomScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([

                            //////////////////////// * Title * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title'),
                                        style: Theme.of(context).textTheme.headline3!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),





                            //////////////////////// * Subtitle * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_subtitle'),
                                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).dividerColor),
                                        minFontSize: 12,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            ),






                            //////////////////////// * popular information Title * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_cards'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),





                            //////////////////////// * 2 cards data * ////////////////////////
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                //////////////////////// * count of Purchases * ////////////////////////
                                buildCard(context , Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_card1_buys'),
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),

                                    SizedBox(height: 12,),

                                    AutoSizeText(
                                        viewModel.getCardPurchases.toString(),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold , color: Theme.of(context).primaryColor),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),


                                  ],
                                )),

                                //////////////////////// * count of Favorites * ////////////////////////
                                buildCard(context , Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_card2_favorite'),
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),

                                    SizedBox(height: 12,),

                                    AutoSizeText(
                                        viewModel.getCardFavorite.toString(),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold , color: Theme.of(context).primaryColor),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),


                                  ],
                                )),

                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),





                            //////////////////////// * 2 cards data * ////////////////////////
                            MediaQuery.of(context).size.width > 800?
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                //////////////////////// * count of Discount * ////////////////////////
                                buildCard(context, Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_card3_discount'),
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),

                                    SizedBox(height: 12,),

                                    SfCircularChart(
                                      series: <CircularSeries>[
                                        RadialBarSeries<ChartDiscountModel, String>(
                                            dataSource: viewModel.getCardDiscount(),
                                            xValueMapper: (ChartDiscountModel data, _) => data.nameMonth,
                                            yValueMapper: (ChartDiscountModel data, _) => data.discountPercent,
                                            dataLabelMapper: (ChartDiscountModel data, _) => data.nameMonth,
                                            // Corner style of radial bar segment
                                            cornerStyle: CornerStyle.bothCurve,
                                            dataLabelSettings: DataLabelSettings(
                                              // Renders the data label
                                                isVisible: true
                                            )

                                        )
                                      ],
                                    ),

                                  ],
                                )),

                                //////////////////////// * count of best foods * ////////////////////////
                                buildCard(context, Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_card4_bestFoods'),
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),

                                    SizedBox(height: 12,),

                                    SfCircularChart(
                                        series: <CircularSeries>[
                                          PieSeries<ChartBestFoodsModel, String>(
                                              dataSource: viewModel.getCardBestFoods(),
                                              xValueMapper: (ChartBestFoodsModel data, _) => data.nameFood,
                                              yValueMapper: (ChartBestFoodsModel data, _) => data.countRequests,
                                              pointRadiusMapper: (ChartBestFoodsModel data, _) => data.size,
                                              pointColorMapper: (ChartBestFoodsModel data, _) => data.color,
                                              dataLabelMapper: (ChartBestFoodsModel data, _) => data.nameFood,
                                              // Segments will explode on tap
                                              explode: true,
                                              // First segment will be exploded on initial rendering
                                              explodeIndex: 1,
                                              dataLabelSettings: DataLabelSettings(
                                                // Renders the data label
                                                  isVisible: true
                                              )
                                          )
                                        ]
                                    )

                                  ],
                                )),


                              ],
                            )
                            :
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [


                                  //////////////////////// * count of Discount CARD * ////////////////////////
                                  buildCard(context, Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      AutoSizeText(
                                          AppLocalizations.of(context)!.translate('chart_card3_discount'),
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                          minFontSize: 18,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis
                                      ),

                                      SizedBox(height: 12,),

                                      SfCircularChart(
                                        series: <CircularSeries>[
                                          RadialBarSeries<ChartDiscountModel, String>(
                                              dataSource: viewModel.getCardDiscount(),
                                              xValueMapper: (ChartDiscountModel data, _) => data.nameMonth,
                                              yValueMapper: (ChartDiscountModel data, _) => data.discountPercent,
                                              dataLabelMapper: (ChartDiscountModel data, _) => data.nameMonth,
                                              // Corner style of radial bar segment
                                              cornerStyle: CornerStyle.bothCurve,
                                              dataLabelSettings: DataLabelSettings(
                                                // Renders the data label
                                                  isVisible: true
                                              )

                                          )
                                        ],
                                      ),

                                    ],
                                  )),
                                  SizedBox(
                                    height: 25,
                                  ),


                                  //////////////////////// * count of best foods CARD * ////////////////////////
                                  buildCard(context, Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      AutoSizeText(
                                          AppLocalizations.of(context)!.translate('chart_card4_bestFoods'),
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                          minFontSize: 18,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis
                                      ),

                                      SizedBox(height: 12,),

                                      SfCircularChart(
                                          series: <CircularSeries>[
                                            PieSeries<ChartBestFoodsModel, String>(
                                                dataSource: viewModel.getCardBestFoods(),
                                                xValueMapper: (ChartBestFoodsModel data, _) => data.nameFood,
                                                yValueMapper: (ChartBestFoodsModel data, _) => data.countRequests,
                                                pointRadiusMapper: (ChartBestFoodsModel data, _) => data.size,
                                                pointColorMapper: (ChartBestFoodsModel data, _) => data.color,
                                                dataLabelMapper: (ChartBestFoodsModel data, _) => data.nameFood,
                                                // Segments will explode on tap
                                                explode: true,
                                                // First segment will be exploded on initial rendering
                                                explodeIndex: 1,
                                                dataLabelSettings: DataLabelSettings(
                                                  // Renders the data label
                                                    isVisible: true
                                                )
                                            )
                                          ]
                                      )

                                    ],
                                  )),
                                ],
                              ),




                            SizedBox(
                              height: 25,
                            ),









                            //////////////////////// * Purchases per months Title (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_purchases_per_months'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * Purchases per months Card (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                color: Theme.of(context).cardColor,
                                child: SfCartesianChart(
                                  // primaryXAxis: DateTimeAxis(),
                                    series: <ChartSeries>[
                                      // Renders area chart
                                      AreaSeries<ChartPurchasesPerMonthModel, int>(
                                          dataSource: viewModel.getPurchasesPerMonth(),
                                          xValueMapper: (ChartPurchasesPerMonthModel sales, _) => sales.monthNumer,
                                          yValueMapper: (ChartPurchasesPerMonthModel sales, _) => sales.purchasesPrice,
                                          xAxisName: AppLocalizations.of(context)!.translate('chart_xName_purchases_per_months'),
                                          yAxisName: AppLocalizations.of(context)!.translate('chart_yName_purchases_per_months'),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.red[100]!,
                                                Colors.red[200]!,
                                                Colors.red
                                              ],
                                              stops: [
                                                0.0,
                                                0.5,
                                                1.0
                                              ]

                                          )
                                      )
                                    ]
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),







                            //////////////////////// * num of order per food title (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_num_of_orders_per_food'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * num of order per food Card (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  color: Theme.of(context).cardColor,
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      series: <ChartSeries>[
                                        SplineSeries<ChartNumOrderFoodsModel, String>(
                                            dataSource: viewModel.getNumOrderFoods(),
                                            // Type of spline
                                            splineType: SplineType.natural,
                                            // cardinalSplineTension: 0.9,
                                            xValueMapper: (ChartNumOrderFoodsModel sales, _) => sales.nameFood,
                                            yValueMapper: (ChartNumOrderFoodsModel sales, _) => sales.numOrders,
                                            xAxisName: AppLocalizations.of(context)!.translate('chart_xName_num_of_orders_per_food'),
                                            yAxisName: AppLocalizations.of(context)!.translate('chart_yName_num_of_orders_per_food'),
                                            color: Theme.of(context).primaryColor
                                        )
                                      ]
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),






                            //////////////////////// * num of discounts per food title (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_num_of_discounts_per_food'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * num of discounts per food Card (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  color: Theme.of(context).cardColor,
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      series: <ChartSeries>[
                                        ColumnSeries<ChartNumDiscountsFoodsModel, String>(
                                            dataSource: viewModel.getNumDiscountsFoods(),
                                            xValueMapper: (ChartNumDiscountsFoodsModel sales, _) => sales.nameFood,
                                            yValueMapper: (ChartNumDiscountsFoodsModel sales, _) => sales.numDicounts,
                                            // Sets the corner radius
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            xAxisName: AppLocalizations.of(context)!.translate('chart_xName_num_of_discounts_per_food'),
                                            yAxisName: AppLocalizations.of(context)!.translate('chart_yName_num_of_discounts_per_food'),
                                            isTrackVisible: false,
                                            enableTooltip: true,
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.red[100]!,
                                                  Colors.red[200]!,
                                                  Colors.red
                                                ],
                                                stops: [
                                                  0.0,
                                                  0.5,
                                                  1.0
                                                ]

                                            ),
                                            borderWidth: 1,
                                            borderGradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.yellow[100]!,
                                                  Colors.yellow[200]!,
                                                  Colors.yellow
                                                ],
                                                stops: [
                                                  0.0,
                                                  0.5,
                                                  1.0
                                                ]
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),







                            //////////////////////// * Forecasting num of orders per month title (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_forecasting_of_orders_per_month'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * * Forecasting num of orders per month Card (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  color: Theme.of(context).cardColor,
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),  //This for String , primaryXAxis if not setup by default is num type , for dataTime use DataTimeAxis()
                                      series: <ChartSeries>[
                                        RangeColumnSeries<ChartForecastingNumOrdersModel, String>(
                                          dataSource: viewModel.getPredictionNumOrdersFoods(),
                                          xValueMapper: (ChartForecastingNumOrdersModel sales, _) => sales.monthName,
                                          lowValueMapper: (ChartForecastingNumOrdersModel sales, _) => sales.lowPredictionNumOrders,
                                          highValueMapper: (ChartForecastingNumOrdersModel sales, _) => sales.highPredictionNumOrders,
                                          pointColorMapper: (ChartForecastingNumOrdersModel sales, _) => Theme.of(context).primaryColor,
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment: ChartDataLabelAlignment.top
                                          ),
                                          xAxisName: AppLocalizations.of(context)!.translate('chart_xName_forecasting_of_orders_per_month'),
                                          yAxisName: AppLocalizations.of(context)!.translate('chart_yName_forecasting_of_orders_per_month'),
                                          // borderColor: ,
                                          // borderRadius: ,
                                          // gradient: LinearGradient(
                                          //     begin: Alignment.bottomCenter,
                                          //     end: Alignment.topCenter,
                                          //     colors: [
                                          //       Colors.red[100]!,
                                          //       Colors.red[200]!,
                                          //       Colors.red
                                          //     ],
                                          //     stops: [
                                          //       0.0,
                                          //       0.5,
                                          //       1.0
                                          //     ]
                                          //
                                          // ),
                                          // borderWidth: 0.5,
                                          // borderGradient: LinearGradient(
                                          //     begin: Alignment.bottomCenter,
                                          //     end: Alignment.topCenter,
                                          //     colors: [
                                          //       Colors.yellow[100]!,
                                          //       Colors.yellow[200]!,
                                          //       Colors.yellow
                                          //     ],
                                          //     stops: [
                                          //       0.0,
                                          //       0.5,
                                          //       1.0
                                          //     ]
                                          // )
                                        )
                                      ]
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),







                            //////////////////////// * Num Of Favorites For Each Food Per Year title  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_num_of_favorite_each_food_per_year'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * Num Of Favorites For Each Food Per Year Card  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  color: Theme.of(context).cardColor,
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      series: <ChartSeries>[
                                        SplineAreaSeries<ChartNumFavEachFoodPerYear, String>(
                                            dataSource: viewModel.getNumFavEachFoodYear()[0],
                                            xValueMapper: (ChartNumFavEachFoodPerYear sales, _) => sales.yearName,
                                            yValueMapper: (ChartNumFavEachFoodPerYear sales, _) => sales.numFav,
                                            color: Colors.red[200],
                                            borderColor: Colors.red,
                                            opacity: 1

                                        ),
                                        SplineAreaSeries<ChartNumFavEachFoodPerYear, String>(
                                            dataSource: viewModel.getNumFavEachFoodYear()[1],
                                            xValueMapper: (ChartNumFavEachFoodPerYear sales, _) => sales.yearName,
                                            yValueMapper: (ChartNumFavEachFoodPerYear sales, _) => sales.numFav,
                                            color: Colors.blue[200],
                                            borderColor: Colors.blue,
                                            opacity: 1

                                        ),
                                        SplineAreaSeries<ChartNumFavEachFoodPerYear, String>(
                                            dataSource: viewModel.getNumFavEachFoodYear()[2],
                                            xValueMapper: (ChartNumFavEachFoodPerYear sales, _) => sales.yearName,
                                            yValueMapper: (ChartNumFavEachFoodPerYear sales, _) => sales.numFav,
                                            color: Colors.green[200],
                                            borderColor: Colors.green,
                                            opacity: 1

                                        ),
                                      ]
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),







                            //////////////////////// * Best three foods title (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_best_three_foods'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * Best three foods card (year 2021)  * ////////////////////////
                            Container(
                              color: Theme.of(context).cardColor,
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                      child: darkMode ?
                                      RadarChart.dark(
                                        data: viewModel.getBestThreeFoods(),
                                        features: ['Orders' , 'Discounts' , 'Favorites'],  //The features and lists of data length must be same (like features = data[0] = 3)
                                        ticks: [10 , 20 , 30 , 40],  //levels of the graph
                                        // featuresTextStyle: Theme.of(context).textTheme.button!.copyWith(),
                                        // ticksTextStyle: Theme.of(context).textTheme.overline!.copyWith(),
                                        // outlineColor: Theme.of(context).textTheme.headline4!.color as Color,
                                        // axisColor: Theme.of(context).dividerColor,
                                      ) :
                                      RadarChart.light(
                                        data: viewModel.getBestThreeFoods(),
                                        features: ['Orders' , 'Discounts' , 'Favorites'],  //The features and lists of data length must be same (like features = data[0] = 3)
                                        ticks: [10 , 20 , 30 , 40],  //levels of the graph
                                        // featuresTextStyle: Theme.of(context).textTheme.button!.copyWith(),
                                        // ticksTextStyle: Theme.of(context).textTheme.overline!.copyWith(),
                                        // outlineColor: Theme.of(context).textTheme.headline4!.color as Color,
                                        // axisColor: Theme.of(context).dividerColor,
                                      )
                                      ,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [

                                          Flexible(
                                            child: AutoSizeText(
                                                'Lolly Burger',
                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          Flexible(
                                            child: AutoSizeText(
                                                'Butter Chicken',
                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          Flexible(
                                            child: AutoSizeText(
                                                'Kebab Pizza',
                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.green),
                                                minFontSize: 10,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),







                            //////////////////////// * DataGrid Purchases title (year 2021)  * ////////////////////////
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)!.translate('chart_title_dataGrid_purchases'),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(),
                                        minFontSize: 18,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //////////////////////// * DataGrid Purchases card (year 2021)  * ////////////////////////
                            Container(
                              color: Theme.of(context).cardColor,
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: SfDataGrid(
                                  source: PurchasesDataSource(purchases: viewModel.getPurchases() , context: context),
                                  columns: [
                                    GridColumn(
                                        columnName: 'id',
                                        label: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'ID',
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    GridColumn(
                                        columnName: 'name',
                                        label: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Name',
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    GridColumn(
                                        columnName: 'quantity',
                                        label: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Quantity',
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    GridColumn(
                                        columnName: 'price',
                                        label: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Price',
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    GridColumn(
                                        columnName: 'discount',
                                        label: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Discount',
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                  ],
                                  selectionMode: SelectionMode.multiple,
                                  controller: dataGridController,
                                ),
                              ),
                            ),
                            SizedBox(height: 5,)



                          ])

                      ),

                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  buildCard(BuildContext context , Widget widget) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocProvider<AnimatedButtonBloc>(
          create: (context) => AnimatedButtonBloc(),
          child: BlocBuilder<AnimatedButtonBloc,AnimatedButtonState>(
              buildWhen: (oldState, newState) => oldState != newState,
              builder: (contextCart, stateCart) {
                return MouseRegion(
                  onExit: (event) =>
                      contextCart.read<AnimatedButtonBloc>().update(false),
                  onEnter: (event) =>
                      contextCart.read<AnimatedButtonBloc>().update(true),
                  // cursor: SystemMouseCursors.basic,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: stateCart.touched ? Theme.of(contextCart).primaryColor : Colors.black54,
                            offset: stateCart.touched ? Offset(0.0, 3.0) : Offset(1.0, 6.0),
                            blurRadius: stateCart.touched ? 4 : 10,
                            spreadRadius: 2.0,
                          )
                        ]
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                            color: Theme.of(contextCart).cardColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: stateCart.touched ? Theme.of(contextCart).accentColor : Colors.black54,
                                offset: Offset(0.0, 5.0),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ]
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(6),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: widget  //Here the widget
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        )
    );
  }

}