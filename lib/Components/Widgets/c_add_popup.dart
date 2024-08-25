import 'package:flutter/material.dart';
import 'package:getactive/Components/Elements/c_text_box.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/Components/Elements/c_text_field.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/Service/s_uuid.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity.dart';
import 'package:getactive/Style/colors.dart';

class CAddPopup extends StatefulWidget {
  const CAddPopup({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<CAddPopup> createState() => _CAddPopupState();
}

class _CAddPopupState extends State<CAddPopup> {
  var nameController = TextEditingController();
  var notesController = TextEditingController();
  String name = "";
  String notes = "";

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
            const SizedBox(height: 40),
            Text(
              "Name",
              style: TextStyle(
                color: pinkText,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            CTextField(
              controller: nameController,
              onChange: (value) => name = value,
            ),
            const SizedBox(height: 40),
            Text(
              "Description",
              style: TextStyle(
                color: pinkText,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            CTextBox(
              controller: notesController,
              onChange: (value) => notes = value,
              readOnly: false,
              focus: FocusNode(),
              lines: 6,
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
            if (name.isNotEmpty) {
              var activity = DsActivity(
                uuid(),
                name,
                widget.index,
                DateTime.now(),
                notes,
              );

              await DaoActivity.insertActivity(activity);
              pop();
            }
          },
          text: "Save",
        ),
      ],
    );
  }
}
