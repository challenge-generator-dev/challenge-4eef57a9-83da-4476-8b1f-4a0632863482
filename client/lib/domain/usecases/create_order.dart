import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:order_app_client/domain/entities/order.dart';
import 'package:order_app_client/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder(this.repository);

  Future<Order> call(Order order) async {
    try {
      if (order.items.isEmpty) {
        throw ArgumentError('Order must contain at least one item');
      }

      final calculatedTotal = order.items.fold(
        0.0,
        (sum, item) => sum + (item.quantity * item.unitPrice),
      );

      final orderWithTotal = order.copyWith(
        totalAmount: calculatedTotal,
        createdAt: DateTime.now(),
        status: OrderStatus.pending,
      );

      final createdOrder = await repository.createOrder(orderWithTotal);
      return createdOrder;
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
          if (error.response?.statusCode == 400) {
            return Exception('Invalid order data');
          } else if (error.response?.statusCode == 409) {
            return Exception('Order already exists');
          }
          return Exception('Server error: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        default:
          return Exception('Network error. Please try again.');
      }
    } else if (error is ArgumentError) {
      return Exception(error.message);
    } else if (error is FormatException) {
      return Exception('Invalid data format received');
    } else {
      return Exception('Failed to create order: $error');
    }
  }
}

final createOrderProvider = Provider<CreateOrder>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return CreateOrder(repository);
});