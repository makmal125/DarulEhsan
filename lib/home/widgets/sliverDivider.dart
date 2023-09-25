// ignore: file_names
import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  const SliverDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Divider(
        height: 20,
        thickness: 5,
        indent: 20,
        endIndent: 20,
        color: Color.fromRGBO(248, 147, 0, 1),
      ),
    );
  }
}