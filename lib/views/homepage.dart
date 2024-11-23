import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_number_app/dependency_injection.dart';
import 'package:random_number_app/view_model/homepage_view_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      injector<HomepageViewModel>().generateNumbers(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Numbers'),
        
      ),
      body: Consumer<HomepageViewModel>(builder: (context, viewModel, child) {
        if (viewModel.numbers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.isOrdered) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Parabéns! Você ordenou a lista!'),
            ));
          });
        }
        return ReorderableListView.builder(
            header: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
              'Movimentos: ${viewModel.moveCount}',
              style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ),
            itemCount: viewModel.numbers.length,
            onReorder: viewModel.reorderNumbers,
            itemBuilder: (context, index) {
              final value = viewModel.numbers[index];
              final isPositionCorrect = value == index + 1;
              return ListTile(
                leading: const Icon(Icons.drag_handle),
                style: ListTileStyle.list,
                key: ValueKey(value),
                trailing: DecoratedBox(
                    decoration: BoxDecoration(
                        color: isPositionCorrect ? Colors.green : Colors.red,
                        shape: BoxShape.circle),
                    child: Icon(
                      isPositionCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                    )),
                title: Text(value.toString()),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          injector<HomepageViewModel>().generateNumbers(10);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
