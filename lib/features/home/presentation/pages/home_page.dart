import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_providers.dart';
import 'transfer_page.dart';
import 'package:financeasy/core/utils/formatters.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinancEasy'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TransferPage()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Saldo disponível', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                      'R\$ ${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Últimas transações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final isEntrada = transaction.value >= 0;
                  return ListTile(
                    leading: Icon(
                      isEntrada ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isEntrada ? Colors.green : Colors.red,
                    ),
                    title: Text(transaction.title),
                    subtitle: Text(
                      dateFormat(transaction.date),
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Text(
                      'R\$ ${transaction.value.toStringAsFixed(2)}',
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
