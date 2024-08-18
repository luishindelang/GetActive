import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:getactive/DB/DataStrukture/ds_activity.dart';

class CReorderableList extends StatefulWidget {
  const CReorderableList({
    super.key,
    required this.list,
    required this.child,
    this.onChanged,
  });

  final List<DsActivity> list;
  final Widget Function(DsActivity) child;
  final Function? onChanged;

  @override
  State<CReorderableList> createState() => _CReorderableListState();
}

class _CReorderableListState extends State<CReorderableList> {
  @override
  Widget build(BuildContext context) {
    Widget proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
    ) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, 1.04, animValue)!;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      proxyDecorator: proxyDecorator,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex--;

          final item = widget.list.removeAt(oldIndex);
          widget.list.insert(newIndex, item);

          widget.onChanged!();
        });
      },
      children: widget.list
          .map((value) => Container(
                key: ValueKey(value.getId),
                child: widget.child(value),
              ))
          .toList(),
    );
  }
}
