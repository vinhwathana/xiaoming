import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xiaoming/views/statistic/utils/statistics_page_wrapper.dart';

class CustomBarSeries<T,D> extends BarSeries {
  CustomBarSeries({
    required List<ChartModel> dataSource,
    // required ChartModel model,
    required String chartTitle,
  }) : super(
          name: chartTitle.toString(),
          dataSource: dataSource,
          xValueMapper: (datum, index) => datum.name,
          yValueMapper: (datum, index) => datum.amount,
          pointColorMapper: (datum, index) => datum.color,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
          enableTooltip: true,
          animationDuration: 500,
        );
}
// return BarSeries(
// name: widget.chartTitle,
// dataSource: certificateData,
// xValueMapper: (datum, index) => datum.name,
// yValueMapper: (datum, index) => datum.amount,
// pointColorMapper: (datum, index) => datum.color,
// dataLabelSettings: const DataLabelSettings(
// isVisible: true,
// ),
// enableTooltip: true,
// animationDuration: 500,
// );
