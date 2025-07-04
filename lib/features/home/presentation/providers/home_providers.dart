import 'package:flutter_riverpod/flutter_riverpod.dart';

// Saldo inicial
final saldoProvider = StateProvider<double>((ref) => 1500.00);

// Lista de transações mock
final transacoesProvider = Provider<List<Map<String, dynamic>>>((ref) => [
  {'titulo': 'Pix recebido', 'valor': 300.0},
  {'titulo': 'Pagamento boleto', 'valor': -120.0},
  {'titulo': 'Transferência enviada', 'valor': -200.0},
]);
