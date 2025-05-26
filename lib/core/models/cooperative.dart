// Classe que representa uma cooperativa com regras para aplicação de desconto em contas
class Cooperative {
  // Nome da cooperativa
  final String nome;

  // Valor mínimo da conta mensal para ser elegível ao desconto
  final double valorMinimoMensal;

  // Valor máximo da conta mensal para ser elegível ao desconto
  final double valorMaximoMensal;

  // Percentual de desconto aplicado sobre o valor da conta
  final double desconto;

  // Construtor da classe, que exige todos os campos como obrigatórios
  Cooperative({
    required this.nome,
    required this.valorMinimoMensal,
    required this.valorMaximoMensal,
    required this.desconto,
  });

  // Verifica se um determinado valor de conta está dentro da faixa permitida para obter desconto
  bool isEligible(double conta) {
    return conta >= valorMinimoMensal && conta <= valorMaximoMensal;
  }

  // Calcula o valor de economia com base no percentual de desconto aplicado sobre a conta
  double calcularEconomia(double conta) {
    return conta * desconto;
  }
}
