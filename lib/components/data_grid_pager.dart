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
  late int selectedPage = widget.selectedPage;

  @override
  Widget build(BuildContext context) {
    numberOfPage = (widget.totalAmount / widget.rowsPerPage).ceil();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_left,
              color: Colors.blueGrey,
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ...List.generate(numberOfPage, (index) {
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
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            widget.onChange(index);
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_right,
              color: Colors.blueGrey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.blueGrey,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Icon(Icons.arrow_back, color: Colors.white),
          //   style: ElevatedButton.styleFrom(
          //     shape: CircleBorder(),
          //     padding: EdgeInsets.all(8),
          //   ),
          // ),
        ],
      ),
    );
  }
}
