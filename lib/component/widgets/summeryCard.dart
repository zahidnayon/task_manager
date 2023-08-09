import 'package:flutter/material.dart';

import '../../style/style.dart';

class summeryCard extends StatelessWidget {
  const summeryCard({
    super.key, required this.number, required this.title,
  });

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('$number',style: Head1Text(colorDark),),
              Text(title,style: Head6Text(colorDark),)
            ],
          ),
        ),
      ),
    );
  }
}