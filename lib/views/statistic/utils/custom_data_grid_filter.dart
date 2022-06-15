import 'package:flutter/material.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/services/autocomplete_service.dart';
import 'package:xiaoming/utils/constant.dart';

class CustomDataGridFilter extends StatefulWidget {
  const CustomDataGridFilter({
    Key? key,
    required this.rowsPerPage,
    required this.onChange,
    this.customFiltersWidget,
  }) : super(key: key);

  final int rowsPerPage;
  final Function(int? index) onChange;
  final List<Widget>? customFiltersWidget;

  @override
  State<CustomDataGridFilter> createState() => _CustomDataGridFilterState();
}

class _CustomDataGridFilterState extends State<CustomDataGridFilter> {
  final autoCompleteService = AutocompleteService();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(
        right: 30,
        left: 8,
      ),
      title: const Text(
        "ច្រោះព័ត៌មាន",
        style: TextStyle(fontSize: 18),
      ),
      leading: Icon(
        Icons.filter_list,
        color: CompanyColors.yellowPrimaryValue,
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      children: [
        ...widget.customFiltersWidget ?? [],
        Row(
          children: [
            const Text(
              "Show : ",
              style: TextStyle(
                color: Colors.black,
                height: 1.5,
              ),
            ),
            DropdownButton(
              underline: null,
              isDense: false,
              itemHeight: 50,
              value: widget.rowsPerPage,
              items: typeOfEntries.map((e) {
                return DropdownMenuItem<int>(
                  value: e,
                  child: Text(
                    e.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                );
              }).toList(),
              onChanged: widget.onChange,
            ),
            const Text(
              " entries ",
              style: TextStyle(
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
