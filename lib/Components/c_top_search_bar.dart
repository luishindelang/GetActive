import 'package:flutter/material.dart';

class CTopSearchBar extends StatelessWidget {
  const CTopSearchBar({
    super.key,
    required this.onSubmit,
    required this.search,
  });

  final Function(String) onSubmit;
  final String search;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: search);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            SizedBox(
              width: 250,
              child: Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Colors.pink[100],
                    selectionColor: Colors.pink[100],
                    selectionHandleColor: Colors.pink[100],
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.pink[200]!,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.only(bottom: 0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.pink[100]!),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.pink[100]!),
                    ),
                  ),
                  controller: controller,
                  onSubmitted: (value) => onSubmit(value),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: IconButton(
                onPressed: () => onSubmit(controller.text),
                icon: Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: Colors.pink[100]!,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.account_box_rounded,
            color: Colors.pink[100]!,
            size: 30,
          ),
        )
      ],
    );
  }
}
