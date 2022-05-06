import 'package:flutter/material.dart';
import 'package:xiaoming/colors/company_colors.dart';

class DataGridPager extends StatefulWidget {
  const DataGridPager({
    Key? key,
    required this.onChange,
    required this.rowsPerPage,
    required this.totalAmount,
    this.selectedPage = 0,
  }) : super(key: key);
  final Function(int index) onChange;
  final int rowsPerPage;
  final int totalAmount;
  final int selectedPage;

  @override
  State<DataGridPager> createState() => _DataGridPagerState();
}

class _DataGridPagerState extends State<DataGridPager> {
  int numberOfPage = 8;

  @override
  Widget build(BuildContext context) {
    numberOfPage = (widget.totalAmount / widget.rowsPerPage).ceil();
    int selectedPage = widget.selectedPage;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            if (selectedPage != 0) {
              widget.onChange(0);
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
        ),
        IconButton(
          onPressed: () {
            final nextIndex = selectedPage - 1;
            if (nextIndex >= 0) {
              widget.onChange(selectedPage - 1);
            }
          },
          icon: const Icon(
            Icons.arrow_left,
            color: Colors.blueGrey,
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  ...List.generate(
                    numberOfPage,
                    (index) {
                      return CircleAvatar(
                        radius: 24,
                        backgroundColor: (index == widget.selectedPage)
                            ? CompanyColors.blue
                            : Colors.transparent,
                        child: IconButton(
                          icon: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: (index == widget.selectedPage)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            widget.onChange(index);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final nextIndex = selectedPage + 1;
            if (nextIndex < numberOfPage) {
              widget.onChange(selectedPage + 1);
            }
          },
          icon: const Icon(
            Icons.arrow_right,
            color: Colors.blueGrey,
          ),
        ),
        IconButton(
          onPressed: () {
            if (selectedPage != (numberOfPage - 1)) {
              widget.onChange(numberOfPage - 1);
            }
          },
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
