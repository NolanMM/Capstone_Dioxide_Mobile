import 'package:dioxide_mobile/pages/graphpage/lib/models/Historical_Prices_Model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class StockChartPage extends StatefulWidget {
  const StockChartPage({super.key});

  @override
  State<StockChartPage> createState() => _StockChartPageState();
}

class _StockChartPageState extends State<StockChartPage> {
  // Sample historical data: last 30 days
  late final List<HistoricalPrice> _allData;
  double _startIndex = 0;
  double _endIndex = 29;

  @override
  void initState() {
    super.initState();
    _allData = _generateSampleData();
  }

  List<HistoricalPrice> _generateSampleData() {
    final today = DateTime.now();
    final rand = Random();
    double base = 100;
    List<HistoricalPrice> list = [];
    for (int i = 0; i < 30; i++) {
      base += rand.nextDouble() * 4 - 2;
      list.add(HistoricalPrice(
        date: today.subtract(Duration(days: 29 - i)),
        price: double.parse(base.toStringAsFixed(2)),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final start = _startIndex.round();
    final end = _endIndex.round();
    final visibleData = _allData.sublist(start, end + 1);

    double rawInterval = (visibleData.length / 4).floorToDouble();
    double xInterval = rawInterval > 0 ? rawInterval : 1.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () {
                // Navigate to Home Page
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Navigate to Search Page
              },
            ),
            IconButton(
              icon: Icon(Icons.bar_chart, color: Colors.black, size: 28,),
              onPressed: () {
                // Navigate to Graph Page
                //Navigator.pushReplacementNamed(context, '/graph');
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/notification');
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Graph Summarize',
                        style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 3.5,      
                        width: 50,     
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 1,      
                  width: double.infinity,     
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                ),
                SizedBox(height: 5),
                Text('Wednesday, 9 July',
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 1,      
                  width: double.infinity,     
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                  value: 'Stock A',
                  items: <String>['Stock A', 'Stock B', 'Stock C'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle stock selection
                  },
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, left: 15, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          'Showing: from ${_allData[start].formattedDate} to ${_allData[end].formattedDate}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        Expanded(
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    interval: xInterval,
                                    getTitlesWidget: (value, meta) {
                                      final idx = value.toInt();
                                      if (idx < 0 || idx >= visibleData.length) return const SizedBox.shrink();
                                      final date = visibleData[idx].date;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          '${date.month}/${date.day}',
                                          style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                        //child: Text('${date.month}/${date.day}'),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: 20, getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                    );
                                    }, 
                                  ),
                                  
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false, reservedSize: 40, interval: 20, getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                    );
                                  }),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    visibleData.length,
                                    (i) => FlSpot(i.toDouble(), visibleData[i].price),
                                  ),
                                  isCurved: false,
                                  barWidth: 3,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.blueAccent,
                            inactiveTrackColor: Colors.grey.shade300,
                            thumbColor: Colors.blueAccent,
                            overlayColor: Colors.blueAccent.withOpacity(0.2),
                          ),
                          child: RangeSlider(
                            min: 1,
                            max: (_allData.length - 1).toDouble(),
                            divisions: _allData.length - 1,
                            labels: RangeLabels(
                              _allData[_startIndex.round()].formattedDate,
                              _allData[_endIndex.round()].formattedDate,
                            ),
                            values: RangeValues(
                              _startIndex < 1 ? 1 : _startIndex,
                              _endIndex,
                            ),
                            onChanged: (values) {
                              setState(() {
                                _startIndex = values.start < 1 ? 1 : values.start;
                                _endIndex = values.end;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, left: 15, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          'Showing: from ${_allData[start].formattedDate} to ${_allData[end].formattedDate}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        Expanded(
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    interval: xInterval,
                                    getTitlesWidget: (value, meta) {
                                      final idx = value.toInt();
                                      if (idx < 0 || idx >= visibleData.length) return const SizedBox.shrink();
                                      final date = visibleData[idx].date;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          '${date.month}/${date.day}',
                                          style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                        //child: Text('${date.month}/${date.day}'),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: 20, getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                    );
                                    }, 
                                  ),
                                  
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false, reservedSize: 40, interval: 20, getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                                    );
                                  }),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    visibleData.length,
                                    (i) => FlSpot(i.toDouble(), visibleData[i].price),
                                  ),
                                  isCurved: false,
                                  barWidth: 3,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.blueAccent,
                            inactiveTrackColor: Colors.grey.shade300,
                            thumbColor: Colors.blueAccent,
                            overlayColor: Colors.blueAccent.withOpacity(0.2),
                          ),
                          child: RangeSlider(
                            min: 1,
                            max: (_allData.length - 1).toDouble(),
                            divisions: _allData.length - 1,
                            labels: RangeLabels(
                              _allData[_startIndex.round()].formattedDate,
                              _allData[_endIndex.round()].formattedDate,
                            ),
                            values: RangeValues(
                              _startIndex < 1 ? 1 : _startIndex,
                              _endIndex,
                            ),
                            onChanged: (values) {
                              setState(() {
                                _startIndex = values.start < 1 ? 1 : values.start;
                                _endIndex = values.end;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
