import 'package:flutter_test/flutter_test.dart';
import 'package:financeasy/features/home/data/models/transaction_model.dart';
import 'package:financeasy/features/home/presentation/providers/home_notifier.dart';

void main() {
  group('TransactionNotifier', () {
    test('Deve iniciar com transações mockadas', () {
      final notifier = TransactionNotifier();
      expect(notifier.state.length, 2);
    });

    test('Deve adicionar nova transação corretamente', () {
      final notifier = TransactionNotifier();

      final transacao = TransactionModel(
        title: 'Nova transferência',
        value: -100,
        date: DateTime.now(),
      );

      notifier.addTransaction(transacao);

      expect(notifier.state.first.title, 'Nova transferência');
      expect(notifier.state.first.value, -100);
      expect(notifier.state.length, 3);
    });

    test('Deve calcular saldo corretamente', () {
      final notifier = TransactionNotifier();
      final saldo = notifier.totalSaldo;
      final esperado = 300 - 120; // base inicial mockada
      expect(saldo, esperado);
    });
  });
}
