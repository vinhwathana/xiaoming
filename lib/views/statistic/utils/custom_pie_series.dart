
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomPieSeries<T,D> extends PieSeries{
  CustomPieSeries({
    required String chartTitle,
    required List<T> dataSource,
  }):super(
    name: chartTitle,
    dataSource: dataSource,
    xValueMapper: (datum, index) => datum.name,
    yValueMapper: (datum, _) => datum.amount.toInt(),
    pointColorMapper: (datum, index) => datum.color,
    dataLabelSettings:  const DataLabelSettings(
      isVisible: true,
      textStyle: TextStyle(fontSize: 20),
    ),
    enableTooltip: true,
    animationDuration: 850,
  );

}