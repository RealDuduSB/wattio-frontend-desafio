import 'package:test/test.dart';
import 'package:test_wattio/core/models/cooperative.dart';

void main() {
  group('Cooperative.calcularEconomia', () {
    test('Retorna o valor correto da economia com base no desconto', () {
      // Instância de uma cooperativa com 20% de desconto
      final coop = Cooperative(
        nome: 'Teste',
        valorMinimoMensal: 1000,
        valorMaximoMensal: 5000,
        desconto: 0.2,
      );

      // 20% de 2000 deve resultar em 400 de economia
      expect(coop.calcularEconomia(2000), equals(400));
    });
  });
}
