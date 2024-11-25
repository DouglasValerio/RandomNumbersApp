import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:random_number_app/view_model/homepage_view_model.dart';
import 'package:random_number_app/views/widgets/homepage_actions.dart';
import 'package:random_number_app/views/widgets/list_item_widget.dart';
import 'package:random_number_app/views/widgets/number_input_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Numbers'),
      ),
      body: Consumer<HomepageViewModel>(builder: (context, viewModel, child) {
        if (viewModel.numbers.isEmpty) {
          return NumberInputWidget(
            onInputComplete: viewModel.generateNumbers,
          );
        }
        if (viewModel.isOrdered) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Validação"),
                  content: Text(
                      "Parabéns, você ordenou a lista em ${viewModel.moveCount} movimentos"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK')),
                  ],
                ),
              );
            }
          });
        }
        return ReorderableListView.builder(
            itemCount: viewModel.numbers.length,
            onReorder: viewModel.reorderNumbers,
            itemBuilder: (context, index) {
              final value = viewModel.numbers[index];
              final isPositionCorrect = value == index + 1;
              return ListItemWidget(
                  key: ValueKey(index),
                  value: value,
                  isPositionCorrect: isPositionCorrect);
            });
      }),
      bottomNavigationBar: const HomepageActions(),
    );
  }
}
