import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:profile/db/notes_database.dart';
import 'package:profile/widget/tabVeiws_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Sales'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TabBar(
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Text(
                              'Today',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'YesDay',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Week',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Month',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        //today
                        TabViewsWidget(
                            futureList: DatabaseHelper.getSales(
                                _getStartDate(0), _getEndDate(0)),
                            futureStats: DatabaseHelper.getSaleStats(
                                _getStartDate(0), _getEndDate(0))),
                        //yesterday
                        TabViewsWidget(
                            futureList: DatabaseHelper.getSales(
                                _getStartDate(1), _getEndDate(1)),
                            futureStats: DatabaseHelper.getSaleStats(
                                _getStartDate(1), _getEndDate(1))),
                        //lastWeek
                        TabViewsWidget(
                            futureList: DatabaseHelper.getSales(
                                _getStartDate(7), _getEndDate(0)),
                            futureStats: DatabaseHelper.getSaleStats(
                                _getStartDate(7), _getEndDate(0))),
                        //lastMonth
                        TabViewsWidget(
                            futureList: DatabaseHelper.getSales(
                                _getStartDate(30), _getEndDate(0)),
                            futureStats: DatabaseHelper.getSaleStats(
                                _getStartDate(30), _getEndDate(0))),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }

  _getStartDate(int day) {
    DateTime startDate = DateTime(now.year, now.month, now.day - 1 * day);
    return startDate;
  }

  _getEndDate(int day) {
    DateTime endDate = DateTime(now.year, now.month, now.day - 1 * day, 24);
    return endDate;
  }
}
