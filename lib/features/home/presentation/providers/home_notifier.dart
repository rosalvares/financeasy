import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/transaction_model.dart';

class TransactionNotifier extends StateNotifier<List<TransactionModel>> {
  TransactionNotifier() : super([
    TransactionModel(title: 'Pix recebido', value: 300, date: DateTime.now()),
    TransactionModel(title: 'Pagamento boleto', value: -120, date: DateTime.now()),
  ]);

  void addTransaction(TransactionModel transaction) {
    state = [transaction, ...state];
  }

  double get totalSaldo {
    return state.fold(0.0, (sum, t) => sum + t.value);
  }
}
