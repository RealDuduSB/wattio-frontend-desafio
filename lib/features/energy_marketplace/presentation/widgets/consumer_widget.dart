import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_wattio/features/energy_marketplace/application/providers.dart';

/// Tela simples que exibe a lista de nomes das cooperativas disponíveis,
/// com base no valor da conta informado pelo usuário.
class MinhaTela extends ConsumerWidget {
  const MinhaTela({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtém a lista de cooperativas filtradas conforme a elegibilidade
    final ofertas = ref.watch(ofertasDisponiveisProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooperativas Disponíveis'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ofertas.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma cooperativa disponível no momento.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: ofertas.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final coop = ofertas[index];
                  return ListTile(title: Text(coop.nome));
                },
              ),
      ),
    );
  }
}
