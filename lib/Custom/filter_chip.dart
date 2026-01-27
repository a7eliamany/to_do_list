import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/global.dart';

class FilterChipCustom extends StatelessWidget {
  final String category;

  final void Function(bool)? onSelected;

  const FilterChipCustom({super.key, required this.category, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      labelStyle: GoogleFonts.pacifico(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      backgroundColor: categoryColors[category],
      onSelected: onSelected ?? (val) {},
      label: Text(category.substring(0, 1).toUpperCase()),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
    );
  }
}
