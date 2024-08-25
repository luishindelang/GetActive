import 'package:flutter/material.dart';
import 'package:getactive/Components/Elements/c_text_box.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/DB/DataStrukture/ds_activity_done.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity_done.dart';
import 'package:getactive/Style/colors.dart';

class CHistoryPopup extends StatefulWidget {
  const CHistoryPopup({
    super.key,
    required this.activity,
  });

  final DsActivityDone activity;

  @override
  State<CHistoryPopup> createState() => _CHistoryPopupState();
}

class _CHistoryPopupState extends State<CHistoryPopup> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  bool readOnly = true;

  void pop() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    _controller.text = widget.activity.getNotes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.activity.getName,
              style: TextStyle(
                color: pinkText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    color: pinkText,
                    fontSize: 18,
                  ),
                ),
                Visibility(
                  visible: readOnly,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        readOnly = false;
                        FocusScope.of(context).requestFocus(_focusNode);
                      });
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                      color: pinkText,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            CTextBox(
              controller: _controller,
              focus: _focusNode,
              onChange: (value) {
                widget.activity.setNotes = value;
              },
              readOnly: readOnly,
              lines: 10,
            ),
          ],
        ),
      ),
      actions: readOnly
          ? [
              CTextButton(
                onPressed: () => pop(),
                text: "Ok",
              ),
            ]
          : [
              CTextButton(
                onPressed: () => setState(() {
                  readOnly = true;
                }),
                text: "Cancel",
              ),
              CTextButton(
                onPressed: () async {
                  await DaoActivityDone.updateNotes(widget.activity);
                  setState(() {
                    readOnly = true;
                  });
                },
                text: "Save",
              ),
            ],
    );
  }
}
