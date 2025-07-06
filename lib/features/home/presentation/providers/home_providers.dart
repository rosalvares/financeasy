import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_notifier.dart';
import '../../data/models/transaction_model.dart';

// Provider do notifier (estado da lista de transações)
final transactionProvider = StateNotifierProvider<TransactionNotifier, List<TransactionModel>>(
      (ref) => TransactionNotifier(),
);

// Provider computado para o saldo total
final balanceProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionProvider);
  return transactions.fold(0.0, (total, t) => total + t.value);
});
