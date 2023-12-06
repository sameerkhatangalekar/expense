import 'package:flutter/cupertino.dart';


import '../../models/category.dart';

class CategoryBadge extends StatelessWidget {
  final Category category;

  const CategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
      decoration: BoxDecoration(
        color: category.color.withAlpha(102),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          color: category.color,
          fontSize: 13,
        ),
      ),
    );
  }
}