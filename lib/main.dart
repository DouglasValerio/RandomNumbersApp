import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_number_app/dependency_injection.dart';
import 'package:random_number_app/view_model/homepage_view_model.dart';
import 'package:random_number_app/views/homepage.dart';

void main() {
  setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VM Teste',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 82, 61)),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => injector<HomepageViewModel>()),
      ],
      child: const Homepage()),
    );
  }
}
