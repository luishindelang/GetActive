import 'package:flutter/material.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/Components/Elements/c_text_field.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity.dart';
import 'package:getactive/Style/colors.dart';

class CEditPopup extends StatefulWidget {
  const CEditPopup({super.key, required this.activity});

  final DsActivity activity;

  @override
  State<CEditPopup> createState() => _CEditPopupState();
}

class _CEditPopupState extends State<CEditPopup> {
  var controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.activity.getName;
    super.initState();
  }

  void pop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: boxBackground,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                    color: pinkText,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await DaoActivity.deleteActivity(widget.activity.getId);
                    pop();
                  },
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    color: pinkText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CTextField(
              controller: controller,
              onChange: (value) {
                widget.activity.setName = value;
              },
            ),
          ],
        ),
      ),
      actions: [
        CTextButton(
          onPressed: () => pop(),
          text: "Cancel",
        ),
        CTextButton(
          onPressed: () async {
            await DaoActivity.updateActivity(widget.activity);
            pop();
          },
          text: "Save",
        ),
      ],
    );
  }
}
