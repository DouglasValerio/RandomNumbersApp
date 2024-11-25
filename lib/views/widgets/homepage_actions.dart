import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_number_app/dependency_injection.dart';
import 'package:random_number_app/view_model/homepage_view_model.dart';

class HomepageActions extends StatelessWidget {
  const HomepageActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (_, model, child) {
      if (model.numbers.isEmpty) {
        return const SizedBox.shrink();
      }
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  injector<HomepageViewModel>().clear();
                },
                child: const Text(
                  "Recomeçar",
                )),
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () async {
                  final isOrdered = model.isOrdered;
                  if (isOrdered) {
                    await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Validação"),
                        content: Text(
                            "Parabéns, você ordenou a lista em ${model.moveCount} movimentos"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK')),
                        ],
                      ),
                    );
                    return;
                  }
                  await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text("Validação"),
                            content:
                                const Text("Sua lista ainda não está ordenada"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK')),
                            ],
                          ));
                },
                child: const Text(
                  "Validar",
                )),
          )
        ],
      );
    });
  }
}
