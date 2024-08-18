import 'package:flutter/material.dart';
import 'package:getactive/Components/c_text_box.dart';
import 'package:getactive/Components/c_text_button.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity.dart';

class CInfoPopup extends StatefulWidget {
  const CInfoPopup({
    super.key,
    required this.activity,
    required this.onHistoryPressed,
  });

  final DsActivity activity;
  final Function onHistoryPressed;

  @override
  State<CInfoPopup> createState() => _CInfoPopupState();
}

class _CInfoPopupState extends State<CInfoPopup> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.pink[200]!,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
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
                          color: Colors.pink[200]!,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => widget.onHistoryPressed(),
                      icon: Icon(
                        Icons.history_rounded,
                        color: Colors.pink[200]!,
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
