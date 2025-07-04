import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_providers.dart';

class HomePage extends ConsumerWidget  {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saldo = ref.watch(saldoProvider);
    final transactions = ref.watch(transacoesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinancEasy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo disponível', style: Theme.of(context).textTheme.titleMedium),
            Text(
              'R\$ ${saldo.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 24),
            const Text('Últimas transações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transacao = transactions[index];
                  final isEntrada = transacao['valor']! >= 0;
                  return ListTile(
                    leading: Icon(isEntrada ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isEntrada ? Colors.green : Colors.red),
                    title: Text(transacao['titulo'].toString()),
                    trailing: Text(
                      'R\$ ${transacao['valor']?.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isEntrada ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
