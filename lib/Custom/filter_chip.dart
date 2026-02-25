import 'package:flutter/material.dart';
import 'package:todo_list/global.dart';

class FilterChipCustom extends StatelessWidget {
  final String category;
  final bool isDeleted;

  final void Function(bool)? onSelected;

  const FilterChipCustom({
    super.key,
    required this.category,
    this.onSelected,
    required this.isDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
        fontFamily: "Pacifico",
      ),
      backgroundColor: (isDeleted)
          ? Colors.red
          : TaskCategoryConfig
                .categoryColors[TaskCategoryConfig.stringToCategory(category)],
      onSelected: onSelected ?? (val) {},
      tooltip: category,
      label: Text(
        (isDeleted) ? "Deleted" : category.substring(0, 2).toUpperCase(),
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
    );
  }
}
