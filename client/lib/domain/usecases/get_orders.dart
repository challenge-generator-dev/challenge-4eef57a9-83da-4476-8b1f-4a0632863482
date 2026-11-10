import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:order_app_client/domain/entities/order.dart';
import 'package:order_app_client/domain/repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders(this.repository);

  Future<List<Order>> call() async {
    try {
      final orders = await repository.getOrders();
      if (orders.isEmpty) {
        return [];
      }
      return orders;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return Exception('Network timeout. Please check your connection.');
        case DioExceptionType.badResponse:
          return Exception('Server error: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        default:
          return Exception('Network error. Please try again.');
      }
    } else if (error is FormatException) {
      return Exception('Invalid data format received');
    } else {
      return Exception('Failed to fetch orders: $error');
    }
  }
}

final getOrdersProvider = Provider<GetOrders>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return GetOrders(repository);
});