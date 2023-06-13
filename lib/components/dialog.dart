import 'package:flutter/material.dart';
import 'package:todo/components/button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({Key? key, required this.controller, required this.onSave, required this.onCancel })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Color.fromARGB(255, 6, 58, 8)),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.green, // Border color when not focused
                        width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.green, // Border color when focused
                        width: 3),
                  ),
                  hintText: "Add a new Task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButton(text: "ADD", onPressed: onSave),
                MyButton(text: "CANCEL", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
