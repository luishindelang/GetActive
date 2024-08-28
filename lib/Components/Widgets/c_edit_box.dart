import 'package:flutter/material.dart';
import 'package:getactive/Components/Elements/c_text_box.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity.dart';
import 'package:getactive/Style/colors.dart';

class CEditBox extends StatefulWidget {
  const CEditBox({
    super.key,
    required this.activity,
    required this.onHistoryPressed,
    this.showHistory = true,
  });

  final DsActivity activity;
  final Function onHistoryPressed;
  final bool showHistory;

  @override
  State<CEditBox> createState() => _CEditBoxState();
}

class _CEditBoxState extends State<CEditBox> {
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
    return Column(
      children: [
        SingleChildScrollView(
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
                lines: 4,
              ),
              Row(
                children: readOnly
                    ? []
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
