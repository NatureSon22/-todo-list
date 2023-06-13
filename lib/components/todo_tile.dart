import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  final void Function(BuildContext) deleteTask;

  TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 35.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteTask, icon: Icons.delete, backgroundColor: const Color.fromARGB(255, 25, 56, 26), foregroundColor: Colors.white),
            ],
        ),
        child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 79, 129, 82),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Checkbox(value: taskCompleted, onChanged: onChanged),
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
