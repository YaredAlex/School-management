import 'package:flutter/material.dart';

class CGrideView extends StatelessWidget {
  const CGrideView(
      {super.key,
      this.column = 2,
      required this.children,
      required this.childrenHeight});
  final double childrenHeight;
  final int column;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: column,
        mainAxisExtent: childrenHeight,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: children,
    );
  }
}
