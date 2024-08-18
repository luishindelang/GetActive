import 'package:flutter/material.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';

class CActivityBox extends StatelessWidget {
  const CActivityBox({
    super.key,
    required this.activity,
    required this.onActivityPressed,
    required this.onEditPressed,
    required this.onInfoPressed,
  });

  final DsActivity activity;
  final Function onActivityPressed;
  final Function onEditPressed;
  final Function onInfoPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                overlayColor:
                    WidgetStateProperty.all(Colors.pink[100]!.withOpacity(0.2)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              onPressed: () => onActivityPressed(),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.getName,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.pink[200]!,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${activity.getLastDone.day}.${activity.getLastDone.month}.${activity.getLastDone.year}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.pink[100]!,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => onEditPressed(),
                icon: Icon(
                  Icons.edit_rounded,
                  color: Colors.pink[200]!,
                ),
              ),
              IconButton(
                onPressed: () => onInfoPressed(),
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.pink[200]!,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
