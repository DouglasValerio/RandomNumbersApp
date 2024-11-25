// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class IncrementWidget extends StatelessWidget {
  final Function(int) onIncrement;
  const IncrementWidget({
    super.key,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: [1, 2, 5, 10, 20, 50, 100]
          .map((i) => TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
              onPressed: () {
                onIncrement(i);
              },
              child: Text("+$i")))
          .toList(),
    );
  }
}
