import 'package:flutter/material.dart';
import 'package:task_manager/data/models/taskListModel.dart';

import '../../style/style.dart';

class taskListTile extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap;

  const taskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                label: Text(
                  data.status ?? "New",
                  style: TextStyle(color: colorWhite),
                ),
                backgroundColor: colorBlue,
              ),
              Spacer(),
              IconButton(
                  onPressed: onEditTap,
                  icon: Icon(
                    Icons.edit,
                    color: colorGreen,
                  )),
              IconButton(
                  onPressed: onDeleteTap,
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: colorRed,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
