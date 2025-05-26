import 'package:flutter_test/flutter_test.dart';
import 'package:test_wattio/core/models/cooperative.dart';

void main() {
  // Grupo de testes para o método isEligible da classe Cooperative
  group('Cooperative.isEligible', () {
    // Instância de cooperativa usada nos testes
    final coop = Cooperative(
      nome: 'EnerTest',
      valorMinimoMensal: 1000,
      valorMaximoMensal: 5000,
      desconto: 0.2,
    );

    test('Retorna true para valor dentro da faixa', () {
      expect(coop.isEligible(3000), isTrue);
    });

    test('Retorna false para valor abaixo do mínimo', () {
      expect(coop.isEligible(500), isFalse);
    });

    test('Retorna false para valor acima do máximo', () {
      expect(coop.isEligible(6000), isFalse);
    });

    test('Retorna true para valor exatamente no mínimo', () {
      expect(coop.isEligible(1000), isTrue);
    });

    test('Retorna true para valor exatamente no máximo', () {
      expect(coop.isEligible(5000), isTrue);
    });
  });
}
