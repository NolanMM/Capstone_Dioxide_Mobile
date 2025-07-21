import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:dioxide_mobile/models/Historical_Prices_Model.dart';
import 'package:dioxide_mobile/models/Stock_Available_Dto.dart';
import 'package:dioxide_mobile/services/graph_services/graph_services.dart';
import 'package:dioxide_mobile/entities/user.dart';

class GraphWidgetPage extends StatefulWidget {
  const GraphWidgetPage({super.key});

  @override
  State<GraphWidgetPage> createState() => _GraphWidgetPageState();
}

class _GraphWidgetPageState extends State<GraphWidgetPage> {
  User? user;
  String _selectedStockSymbol = 'AAPL';
  List<StockAvailableDto> _availableStocks = [];
  List<HistoricalPrice> _historicalPrices = [];
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  final List<String> _optionsType = ['Close', 'Open', 'High', 'Low'];
  final List<String> _selectedOptionsType = ['Close'];

  bool _isLoading = true;
  double _minY = 0;
  double _maxY = 200;

  final List<Color> _gradientColors = [
    const Color(0xFF23B6E6),
    const Color(0xFF02D39A),
  ];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _selectedStartDate = DateTime.now().subtract(const Duration(days: 90));
    _selectedEndDate = DateTime.now();

    await _loadAvailableStocks();
    if (mounted && _availableStocks.isNotEmpty) {
      await _updateData();
    } else if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadAvailableStocks() async {
    final stocks = await GraphService.getAvailableStockSymbols();
    if (mounted) {
      setState(() {
        _availableStocks = stocks;
        if (_availableStocks.isNotEmpty) {
          _selectedStockSymbol = _availableStocks.first.Stock_Symbol;
        }
      });
    }
  }

  Future<void> _fetchAndApplyPredictions() async {
    if (_selectedStockSymbol.isEmpty) return;

    try {
      final predictions = await GraphService.fetchPredictions(
        ticker: _selectedStockSymbol,
      );

      if (mounted) {
        setState(() {
          _historicalPrices.addAll(predictions);
          _calculateMinMaxY();
        });
      }
    } catch (e) {
      print('Error fetching predictions: $e');
    }
  }

  Future<void> _updateData() async {
    if (_selectedStockSymbol.isEmpty ||
        _selectedStartDate == null ||
        _selectedEndDate == null) return;

    setState(() {
      _isLoading = true;
    });

    final data = await _fetchData(
      _selectedStockSymbol,
      _selectedStartDate!.toIso8601String(),
      _selectedEndDate!.toIso8601String(),
    );

    if (mounted) {
      setState(() {
        _historicalPrices = data;
        _calculateMinMaxY();
        _isLoading = false;
      });

       _fetchAndApplyPredictions();
    }
  }

  void _calculateMinMaxY() {
    if (_historicalPrices.isEmpty || _selectedOptionsType.isEmpty) {
      _minY = 0;
      _maxY = 200; // Default range
      return;
    }

    double minVal = double.maxFinite;
    double maxVal = double.minPositive;

    for (var price in _historicalPrices) {
      for (var type in _selectedOptionsType) {
        switch (type) {
          case 'Open':
            if (price.open < minVal) minVal = price.open;
            if (price.open > maxVal) maxVal = price.open;
            break;
          case 'High':
            if (price.high < minVal) minVal = price.high;
            if (price.high > maxVal) maxVal = price.high;
            break;
          case 'Low':
            if (price.low < minVal) minVal = price.low;
            if (price.low > maxVal) maxVal = price.low;
            break;
          case 'Close':
          default:
            if (price.close < minVal) minVal = price.close;
            if (price.close > maxVal) maxVal = price.close;
            break;
        }
      }
    }

    setState(() {
      _minY = minVal * 0.95; // Add 5% padding below
      _maxY = maxVal * 1.05; // Add 5% padding above
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime now = DateTime.now();
    final DateTime initial = isStartDate
        ? (_selectedStartDate ?? now.subtract(const Duration(days: 30)))
        : (_selectedEndDate ?? now);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2010, 1, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (!isStartDate && picked.isAfter(now)) {
        _showErrorDialog(context, "End date cannot be in the future.");
        return;
      }
      if (isStartDate &&
          _selectedEndDate != null &&
          picked.isAfter(_selectedEndDate!)) {
        _showErrorDialog(context, "Start date cannot be after end date.");
        return;
      }
      if (!isStartDate &&
          _selectedStartDate != null &&
          picked.isBefore(_selectedStartDate!)) {
        _showErrorDialog(context, "End date cannot be before start date.");
        return;
      }

      setState(() {
        if (isStartDate) {
          _selectedStartDate = picked;
        } else {
          _selectedEndDate = picked;
        }
      });
      _updateData();
    }
  }

  void _showMultiSelectDialog() async {
    final List<String>? selected = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        final List<String> tempSelected = List.from(_selectedOptionsType);
        return AlertDialog(
          title: const Text('Select Types'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: _optionsType.map((type) {
                  return CheckboxListTile(
                    value: tempSelected.contains(type),
                    title: Text(type),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          tempSelected.add(type);
                        } else {
                          tempSelected.remove(type);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, tempSelected),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedOptionsType.clear();
        _selectedOptionsType.addAll(selected);
        if (_selectedOptionsType.isEmpty) {
          _selectedOptionsType.add('Close');
        }
        _calculateMinMaxY(); // Recalculate Y-axis for new types
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Invalid Date"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // List<LineChartBarData> _getLineBarsData() {
  //   final List<LineChartBarData> lineBarsData = [];
  //   final List<Color> colors = [
  //     Colors.blue,
  //     Colors.red,
  //     Colors.green,
  //     Colors.orange
  //   ];

  //   for (int i = 0; i < _selectedOptionsType.length; i++) {
  //     final type = _selectedOptionsType[i];
  //     final color = colors[i % colors.length];

  //     List<FlSpot> spots = _historicalPrices.asMap().entries.map((entry) {
  //       final index = entry.key.toDouble();
  //       final price = entry.value;
  //       switch (type) {
  //         case 'Open':
  //           return FlSpot(index, price.open);
  //         case 'High':
  //           return FlSpot(index, price.high);
  //         case 'Low':
  //           return FlSpot(index, price.low);
  //         case 'Close':
  //         default:
  //           return FlSpot(index, price.close);
  //       }
  //     }).toList();

  //     if (spots.isNotEmpty) {
  //       lineBarsData.add(
  //         LineChartBarData(
  //           spots: spots,
  //           isCurved: true,
  //           color: color,
  //           barWidth: 2.5,
  //           isStrokeCapRound: true,
  //           dotData: const FlDotData(show: false),
  //           belowBarData: BarAreaData(show: false),
  //         ),
  //       );
  //     }
  //   }
  //   return lineBarsData;
  // }

  List<LineChartBarData> _getLineBarsData() {
  final List<LineChartBarData> lineBarsData = [];
  // Use a map for clearer color associations
  final Map<String, Color> typeColors = {
    'Open': Colors.red,
    'High': Colors.green,
    'Low': Colors.orange,
    'Close': Colors.blue, // Base color for historical close price
  };
  const Color predictionColor = Colors.purple; // Color for predicted values

  for (final type in _selectedOptionsType) {
    final color = typeColors[type] ?? Colors.grey;

    // Special handling for the "Close" price to show predictions
    if (type == 'Close') {
      final List<FlSpot> historicalSpots = [];
      final List<FlSpot> predictionSpots = [];
      int? lastHistoricalIndex;

      // 1. Separate data into historical and prediction lists
      for (int i = 0; i < _historicalPrices.length; i++) {
        final price = _historicalPrices[i];
        final spot = FlSpot(i.toDouble(), price.close);

        if (price.isPrediction) {
          predictionSpots.add(spot);
        } else {
          historicalSpots.add(spot);
          lastHistoricalIndex = i;
        }
      }

      // 2. Ensure a seamless connection between the two lines
      if (lastHistoricalIndex != null && predictionSpots.isNotEmpty) {
        final connectionPoint = FlSpot(
          lastHistoricalIndex.toDouble(),
          _historicalPrices[lastHistoricalIndex].close,
        );
        predictionSpots.insert(0, connectionPoint);
      }

      // 3. Add the historical data line
      if (historicalSpots.isNotEmpty) {
        lineBarsData.add(
          LineChartBarData(
            spots: historicalSpots,
            isCurved: true,
            color: color, // Historical color (blue)
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        );
      }

      // 4. Add the prediction data line
      if (predictionSpots.isNotEmpty) {
        lineBarsData.add(
          LineChartBarData(
            spots: predictionSpots,
            isCurved: true,
            color: predictionColor, // Prediction color (purple)
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        );
      }
    } else {
      // Original logic for other types (Open, High, Low)
      final List<FlSpot> spots = _historicalPrices.asMap().entries.map((entry) {
        final index = entry.key.toDouble();
        final price = entry.value;
        double yValue;
        switch (type) {
          case 'Open':
            yValue = price.open;
            break;
          case 'High':
            yValue = price.high;
            break;
          case 'Low':
            yValue = price.low;
            break;
          default:
            yValue = 0;
        }
        return FlSpot(index, yValue);
      }).toList();

      if (spots.isNotEmpty) {
        lineBarsData.add(
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        );
      }
    }
  }
  return lineBarsData;
}

  Widget _buildBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    final index = value.toInt();

    if (index < 0 || index >= _historicalPrices.length) {
      return const SizedBox();
    }

    final date = _historicalPrices[index].date;
    String text = '${date.month}/${date.day}';

    return SideTitleWidget(
      meta: meta,
      space: 8.0,
      child: Text(text, style: style),
    );
  }

  Widget _buildLeftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text = value.toStringAsFixed(0);

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalColumnsTypes = 1 + _selectedOptionsType.length;
    final columnSpacingTypes = (screenWidth) / totalColumnsTypes - 60;

    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments.containsKey('user')) {
      user = arguments['user'] as User?;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 40,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home', arguments: {'user': user});
              },
            ),
            IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/search', arguments: {'user': user});
                }),
            IconButton(
                icon: const Icon(Icons.bar_chart, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/graph', arguments: {'user': user});
                }),
            IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/notification', arguments: {'user': user});
                }),
            IconButton(
                icon: const Icon(Icons.person, color: Colors.black, size: 28),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile', arguments: {'user': user});
                }),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Graph Widget',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 3.5,
                width: 50,
                color: Colors.black,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
              ),
              const SizedBox(height: 20),
              if (_availableStocks.isEmpty && !_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("No stock symbols available to display."),
                  ),
                )
              else if (_availableStocks.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Stock Symbol Dropdown
                        Expanded(
                          flex: 2,
                          child: DropdownButton<String>(
                            value: _selectedStockSymbol,
                            isExpanded: true,
                            items: _availableStocks.map((s) {
                              return DropdownMenuItem(
                                value: s.Stock_Symbol,
                                child: Text(s.Stock_Symbol),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue == null) return;
                              setState(() => _selectedStockSymbol = newValue);
                              _updateData();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Types Multi-select Button
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: _showMultiSelectDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Types: ${_selectedOptionsType.join(', ')}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Date Pickers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            _selectedStartDate != null
                                ? '${_selectedStartDate!.toLocal()}'
                                    .split(' ')[0]
                                : 'Start',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, true),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            _selectedEndDate != null
                                ? '${_selectedEndDate!.toLocal()}'.split(' ')[0]
                                : 'End',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, false),
                          ),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 10),

                    // Loading indicator or Chart/Table content
                    _isLoading
                        ? const Center(
                            heightFactor: 10,
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  'Prices for $_selectedStockSymbol',
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                // Line Chart
                                AspectRatio(
                                  aspectRatio: 1.5,
                                  child: LineChart(
                                    LineChartData(
                                      minY: _minY,
                                      maxY: _maxY,
                                      gridData: FlGridData(
                                        show: true,
                                        drawVerticalLine: true,
                                        horizontalInterval: (_maxY - _minY) / 4,
                                        getDrawingHorizontalLine: (value) =>
                                            const FlLine(
                                          color: Color(0xffe7e8ec),
                                          strokeWidth: 1,
                                        ),
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 30,
                                            interval: max(
                                                1,
                                                (_historicalPrices.length / 6)
                                                    .floor()
                                                    .toDouble()),
                                            getTitlesWidget:
                                                _buildBottomTitleWidgets,
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 40,
                                            getTitlesWidget:
                                                _buildLeftTitleWidgets,
                                          ),
                                        ),
                                        topTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                      ),
                                      borderData: FlBorderData(
                                        show: true,
                                        border: Border.all(
                                            color: const Color(0xffe7e8ec)),
                                      ),
                                      lineBarsData: _getLineBarsData(),
                                      lineTouchData: LineTouchData(
                                        touchTooltipData: LineTouchTooltipData(
                                          fitInsideHorizontally: true,
                                          fitInsideVertically: true,
                                          getTooltipItems:
                                              (List<LineBarSpot> touchedSpots) {
                                            if (touchedSpots.isEmpty) {
                                              return [];
                                            }

                                            final int index = touchedSpots
                                                .first.spotIndex;

                                            if (index < 0 ||
                                                index >=
                                                    _historicalPrices.length) {
                                              return List.generate(
                                                  touchedSpots.length,
                                                  (index) => null);
                                            }

                                            final data =
                                                _historicalPrices[index];
                                            final List<LineTooltipItem?>
                                                tooltipItems = [];

                                            final richTooltip = LineTooltipItem(
                                              'Date: ${data.date.toLocal().toString().split(' ')[0]}\n',
                                              const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.left,
                                              children: [
                                                if (_selectedOptionsType
                                                    .contains('Open'))
                                                  TextSpan(
                                                      text:
                                                          'O: ${data.open.toStringAsFixed(2)} ',
                                                      style: const TextStyle(
                                                          color: Colors.blue)),
                                                if (_selectedOptionsType
                                                    .contains('High'))
                                                  TextSpan(
                                                      text:
                                                          'H: ${data.high.toStringAsFixed(2)} ',
                                                      style: const TextStyle(
                                                          color: Colors.green)),
                                                if (_selectedOptionsType
                                                    .contains('Low'))
                                                  TextSpan(
                                                      text:
                                                          'L: ${data.low.toStringAsFixed(2)} ',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.orange)),
                                                if (_selectedOptionsType
                                                    .contains('Close'))
                                                  TextSpan(
                                                      text:
                                                          'C: ${data.close.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          color: Colors.red)),
                                              ],
                                            );

                                            tooltipItems.add(richTooltip);

                                            for (int i = 1;
                                                i < touchedSpots.length;
                                                i++) {
                                              tooltipItems.add(null);
                                            }

                                            return tooltipItems;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Historical Prices',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                // Data Table
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: columnSpacingTypes,
                                    horizontalMargin: 10,
                                    columns: [
                                      const DataColumn(
                                          label: Text('Date',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      ..._selectedOptionsType.map(
                                        (type) => DataColumn(
                                            label: Text(type,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ],
                                    rows: _historicalPrices.map((price) {
                                      List<DataCell> cells = [
                                        DataCell(Text(price.date
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0])),
                                      ];
                                      for (var type in _selectedOptionsType) {
                                        switch (type) {
                                          case 'Close':
                                            cells.add(DataCell(Text(price.close
                                                .toStringAsFixed(2))));
                                            break;
                                          case 'Open':
                                            cells.add(DataCell(Text(
                                                price.open.toStringAsFixed(2))));
                                            break;
                                          case 'High':
                                            cells.add(DataCell(Text(
                                                price.high.toStringAsFixed(2))));
                                            break;
                                          case 'Low':
                                            cells.add(DataCell(Text(
                                                price.low.toStringAsFixed(2))));
                                            break;
                                        }
                                      }
                                      return DataRow(cells: cells);
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
  Future<List<HistoricalPrice>> _fetchData(
    String stockSymbol,
    String startDateStr,
    String endDateStr,
  ) async {
    return GraphService.fetchHistoricalPricesByDateRange(
      stockSymbol,
      startDateStr,
      endDateStr,
    );
  }
}