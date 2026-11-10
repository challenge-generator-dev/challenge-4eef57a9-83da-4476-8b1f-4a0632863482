import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app_client/presentation/screens/orders_screen.dart';

void main() {
  runApp(const ProviderScope(child: OrderApp()));
}

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OrdersScreen(),
    );
  }
}

// Providers globales para inyección de dependencias
final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://<load_balancer_dns>/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
});

final orderRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return OrderRepositoryImpl(OrderApi(dio));
});