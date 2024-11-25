import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.value,
    required this.isPositionCorrect,
  });

  final int value;
  final bool isPositionCorrect;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
     key: key,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ListTile(
        trailing: const Icon(Icons.drag_handle),
        style: ListTileStyle.list,
        leading: DecoratedBox(
            decoration: BoxDecoration(
                color: isPositionCorrect ? Colors.green : Colors.red,
                shape: BoxShape.circle),
            child: Icon(
              isPositionCorrect ? Icons.check : Icons.close,
              color: Colors.white,
            )),
        title: Text(
          value.toString(),
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
