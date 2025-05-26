import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_wattio/core/models/cooperative.dart';
import '../../application/providers.dart';

/// Tela principal onde o usuário informa o valor da conta de energia,
/// visualiza cooperativas elegíveis e pode calcular a economia estimada.
///
/// Essa tela utiliza Riverpod para gerenciar o estado da entrada do usuário
/// e o carregamento das ofertas.
class EnergyInputScreen extends ConsumerStatefulWidget {
  const EnergyInputScreen({super.key});

  @override
  ConsumerState<EnergyInputScreen> createState() => _EnergyInputScreenState();
}

class _EnergyInputScreenState extends ConsumerState<EnergyInputScreen> {
  // Valor atual do slider
  double _sliderValue = 1000;

  // Controlador do campo de texto que recebe o valor da conta
  final TextEditingController _controller = TextEditingController();

  // Mensagem de erro para exibição abaixo do campo, se necessário
  String? _erro;

  @override
  void initState() {
    super.initState();

    // Define o valor inicial como 1000
    _controller.text = '1000';

    // Aguarda a montagem do widget antes de atualizar o estado gerenciado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userInputProvider.notifier).state = 1000;
    });
  }

  /// Valida o valor inserido e simula a busca das ofertas com pequeno atraso
  void _buscarOfertas() async {
    final valor = double.tryParse(_controller.text.replaceAll(',', '.'));
    if (valor == null || valor <= 0) {
      setState(() {
        _erro = 'Digite um valor válido maior que zero';
      });
      ref.read(userInputProvider.notifier).state = null;
      return;
    }

    setState(() {
      _erro = null;
    });

    // Ativa o estado de carregamento
    ref.read(isLoadingProvider.notifier).state = true;

    // Simula carregamento com delay de 0.5s
    await Future.delayed(const Duration(milliseconds: 500));

    // Atualiza o valor de entrada do usuário
    ref.read(userInputProvider.notifier).state = valor;
    ref.read(isLoadingProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    // Consome os estados providos por Riverpod
    final userInput = ref.watch(userInputProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final ofertas = ref.watch(ofertasDisponiveisProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF2A3132),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Título e ícone superior
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.store, color: Colors.white),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Calcule a economia da sua empresa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Subtítulo informativo
              Text(
                'O valor médio mensal da minha conta de energia é:',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Campo de texto customizado com sombra e prefixo R$
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF89DA59),
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFF420E),
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onChanged: (value) {
                        final parsed = double.tryParse(
                          value.replaceAll(',', '.'),
                        );
                        if (parsed != null) {
                          setState(() {
                            _sliderValue = parsed.clamp(1000, 100000);
                          });
                        }
                      },
                    ),
                    const Positioned(
                      left: 32,
                      child: Text(
                        'R\$',
                        style: TextStyle(
                          color: Color(0xFFFF420E),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Mensagem de erro, se aplicável
              if (_erro != null) ...[
                const SizedBox(height: 8),
                Text(_erro!, style: const TextStyle(color: Colors.red)),
              ],

              const SizedBox(height: 20),

              // Instrução abaixo do campo
              Text(
                'Digite o valor acima ou mova a barra abaixo. Mínimo é R\$1.000',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // Slider sincronizado com o campo
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: const Color(0xFFFF420E),
                  activeTrackColor: const Color(0xFFFF420E),
                  inactiveTrackColor: const Color(0xFF89DA59),
                ),
                child: Slider(
                  min: 1000,
                  max: 100000,
                  divisions: 1000,
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      _controller.text = value.toStringAsFixed(0);
                    });
                  },
                ),
              ),

              // Botão principal para buscar ofertas
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _buscarOfertas,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF420E),
                    foregroundColor: const Color(0xFF2A3132),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Calcular ofertas!',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Indicador de carregamento
              if (isLoading)
                const CircularProgressIndicator()
              // Lista de ofertas disponíveis
              else if (ofertas.isNotEmpty) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ofertas Disponíveis:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ofertas.length,
                  itemBuilder: (context, index) {
                    final coop = ofertas[index];
                    final economia = coop.calcularEconomia(userInput!);
                    final format = NumberFormat.currency(
                      locale: 'pt_BR',
                      symbol: 'R\$',
                    );

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          coop.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Desconto: ${(coop.desconto * 100).toStringAsFixed(0)}%',
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Economia com ${coop.nome}'),
                                content: Text(
                                  'Você economizaria ${format.format(economia)} por mês.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF420E),
                          ),
                          child: const Text('Selecionar'),
                        ),
                      ),
                    );
                  },
                ),
              ]
              // Caso não haja cooperativas elegíveis
              else if (userInput != null && _erro == null) ...[
                const Text(
                  'Nenhuma cooperativa disponível para esse valor.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
