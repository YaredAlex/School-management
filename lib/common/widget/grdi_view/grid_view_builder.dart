import 'package:flutter/material.dart';

class CGrideViewBuilder extends StatelessWidget {
  const CGrideViewBuilder(
      {super.key,
      this.column = 2,
      required this.itemBuilder,
      required this.childrenHeight});
  final double childrenHeight;
  final int column;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: itemBuilder,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: column,
        mainAxisExtent: childrenHeight,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
    );
  }
}
