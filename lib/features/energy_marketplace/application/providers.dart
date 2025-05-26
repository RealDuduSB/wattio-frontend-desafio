import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_wattio/core/models/cooperative.dart';

// Provider responsável por armazenar o valor da conta informado pelo usuário.
// O valor pode ser nulo inicialmente.
final userInputProvider = StateProvider<double?>((ref) => null);

// Provider que retorna a lista fixa de cooperativas disponíveis no sistema.
final cooperativasProvider = Provider<List<Cooperative>>(
  (ref) => [
    Cooperative(
      nome: 'EnerFácil',
      valorMinimoMensal: 1000,
      valorMaximoMensal: 40000,
      desconto: 0.2,
    ),
    Cooperative(
      nome: 'EnerLimpa',
      valorMinimoMensal: 10000,
      valorMaximoMensal: 80000,
      desconto: 0.25,
    ),
    Cooperative(
      nome: 'EnerGrande',
      valorMinimoMensal: 40000,
      valorMaximoMensal: 100000,
      desconto: 0.3,
    ),
  ],
);

// Provider que calcula dinamicamente quais cooperativas estão disponíveis
// para o valor de conta informado pelo usuário.
// Retorna uma lista filtrada com base nos critérios de elegibilidade.
final ofertasDisponiveisProvider = Provider<List<Cooperative>>((ref) {
  final conta = ref.watch(userInputProvider);
  final cooperativas = ref.watch(cooperativasProvider);

  // Se o valor da conta não foi informado, retorna uma lista vazia
  if (conta == null) return [];

  // Retorna apenas as cooperativas para as quais a conta está dentro da faixa permitida
  return cooperativas.where((c) => c.isEligible(conta)).toList();
});

// Provider que controla o estado de carregamento, útil para indicar
// operações assíncronas em andamento na interface do usuário.
final isLoadingProvider = StateProvider<bool>((ref) => false);
