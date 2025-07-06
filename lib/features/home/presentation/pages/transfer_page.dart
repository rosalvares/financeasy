import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/transaction_model.dart';
import '../providers/home_providers.dart';

class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({super.key});

  @override
  ConsumerState<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _doTransfer() {
    if (_formKey.currentState?.validate() ?? false) {
      final value = double.parse(_valorController.text);
      final balance = ref.read(balanceProvider);

      if (value > balance) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saldo insuficiente')),
        );
        return;
      }

      ref.read(transactionProvider.notifier).addTransaction(
        TransactionModel(
          title: 'Transferência enviada',
          value: -value,
          date: DateTime.now(),
        ),
      );

      Navigator.pop(context); // volta para a Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transferência')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _valorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor da transferência'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um valor';
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) {
                    return 'Valor inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _doTransfer,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
