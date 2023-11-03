import 'package:flutter/material.dart';

class AdaptiveTable<T> extends StatelessWidget {
  const AdaptiveTable({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.breakpoint = 600,
  });

  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      if (dimens.maxWidth >= breakpoint) {
        return Container();
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return itemBuilder(item, index);
        },
      );
    });
  }
}
