import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_wattio/features/energy_marketplace/presentation/screens/energy_input_screen.dart';

/// Ponto de entrada da aplicação.
/// O [ProviderScope] é necessário para que o Riverpod funcione corretamente.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// Widget principal da aplicação.
/// Define o tema e a tela inicial do app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wattio Marketplace',
      theme: ThemeData(
        // Define o esquema de cores baseado em um seed (cor base)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true, // Habilita o Material 3 (mais moderno)
      ),
      home: const EnergyInputScreen(), // Tela inicial da aplicação
    );
  }
}
