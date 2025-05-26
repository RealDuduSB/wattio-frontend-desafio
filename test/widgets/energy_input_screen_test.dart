import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_wattio/features/energy_marketplace/presentation/screens/energy_input_screen.dart';

void main() {
  group('EnergyInputScreen Widget Tests', () {
    testWidgets('Tela carrega com campo de input e texto inicial', (
      tester,
    ) async {
      // Monta o widget dentro de ProviderScope e MaterialApp
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: EnergyInputScreen())),
      );

      // Verifica se o texto introdutório está presente
      expect(
        find.text('Informe o valor médio da sua conta de energia (R\$)'),
        findsOneWidget,
      );

      // Verifica se o campo de texto está renderizado
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Campo de input aceita valor e mostra cooperativas elegíveis', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: EnergyInputScreen())),
      );

      // Digita o valor 15000 (deve ser elegível para EnerFácil e EnerLimpa)
      await tester.enterText(find.byType(TextField), '15000');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Espera a atualização da interface com o delay simulado
      await tester.pumpAndSettle();

      // Verifica se as cooperativas elegíveis são exibidas
      expect(find.text('EnerFácil'), findsOneWidget);
      expect(find.text('EnerLimpa'), findsOneWidget);
      expect(
        find.text('EnerGrande'),
        findsNothing,
      ); // valor ainda abaixo da faixa mínima de EnerGrande
    });

    testWidgets('Nenhuma cooperativa aparece para valor fora da faixa', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: EnergyInputScreen())),
      );

      // Digita valor abaixo do mínimo necessário para qualquer cooperativa
      await tester.enterText(find.byType(TextField), '500');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Aguarda a interface atualizar
      await tester.pumpAndSettle();

      // Verifica que não há ofertas disponíveis
      expect(find.text('Ofertas Disponíveis:'), findsNothing);
      expect(
        find.text('Nenhuma cooperativa disponível para esse valor.'),
        findsOneWidget,
      );
    });
  });
}
