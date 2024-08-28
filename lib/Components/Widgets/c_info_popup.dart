import 'package:flutter/material.dart';
import 'package:getactive/Components/Elements/c_text_box.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity.dart';
import 'package:getactive/Style/colors.dart';

class CInfoPopup extends StatefulWidget {
  const CInfoPopup({
    super.key,
    required this.activity,
    required this.onHistoryPressed,
    this.showHistory = true,
  });

  final DsActivity activity;
  final Function onHistoryPressed;
  final bool showHistory;

  @override
  State<CInfoPopup> createState() => _CInfoPopupState();
}

class _CInfoPopupState extends State<CInfoPopup> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  bool readOnly = true;

  @override
  void initState() {
    _controller.text = widget.activity.getNotes;
    super.initState();
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (readOnly) {
                          setState(() {
                            readOnly = false;
                            FocusScope.of(context).requestFocus(_focusNode);
                          });
                        } else {
                          setState(() {
                            _controller.clear();
                          });
                        }
                      },
                      icon: Icon(
                        readOnly ? Icons.edit_rounded : Icons.close_rounded,
                        color: pinkText,
                      ),
                    ),
                    Visibility(
                      visible: widget.showHistory,
                      child: IconButton(
                        onPressed: () => widget.onHistoryPressed(),
                        icon: Icon(
                          Icons.history_rounded,
                          color: pinkText,
                        ),
                      ),
                    ),
                  ],
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
                onPressed: () => Navigator.pop(context),
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
                  await DaoActivity.updateActivity(widget.activity);
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
