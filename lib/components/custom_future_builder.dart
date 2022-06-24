import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/custom_error_widget.dart';
import 'package:xiaoming/components/loading_widget.dart';

class CustomFutureBuilder<T> extends StatefulWidget {
  const CustomFutureBuilder({
    Key? key,
    required this.future,
    this.onLoading,
    this.onError,
    required this.onDataRetrieved,
  }) : super(key: key);
  final Future<T> future;
  final Widget? onLoading;
  final Widget? onError;
  final Widget Function(
          BuildContext context, T? result, ConnectionState connectionState)
      onDataRetrieved;

  @override
  State<CustomFutureBuilder<T>> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.onError ??
              CustomErrorWidget(
                text: "errorOccurred".tr,
              );
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            return widget.onDataRetrieved(
              context,
              snapshot.data!,
              snapshot.connectionState,
            );
          }

          return Text("errorOccurred".tr);
        } else if(snapshot.connectionState == ConnectionState.done){
          return widget.onDataRetrieved(
            context,
            null,
            snapshot.connectionState,
          );
        }else {
          return widget.onLoading ?? const LoadingWidget();
        }
      },
    );
  }
}
