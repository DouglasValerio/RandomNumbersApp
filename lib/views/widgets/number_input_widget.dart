// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:random_number_app/views/widgets/increment_widget.dart';

class NumberInputWidget extends StatelessWidget {
  final Function(int) onInputComplete;
  NumberInputWidget({
    super.key,
    required this.onInputComplete,
  });
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Quantidade de números'),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Quantidade',
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              final quantity = int.tryParse(value);
              if (quantity != null) {
                onInputComplete(quantity);
              }
            },
          ),
          const SizedBox(height: 8.0),
          IncrementWidget(
            onIncrement: (p0) {
              controller.text =
                  ((int.tryParse(controller.text) ?? 0) + p0).toString();
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                final quantity = int.tryParse(controller.text);
                if (quantity != null) {
                  onInputComplete(quantity);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Digite um número válido'),
                  ));
                }
              },
              child: const Text(
                'Gerar números',
              )),
        ],
      ),
    );
  }
}
