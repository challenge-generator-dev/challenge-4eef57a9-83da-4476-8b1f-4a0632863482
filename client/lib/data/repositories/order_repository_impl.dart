import 'package:dio/dio.dart';
import '../../domain/entities/order.dart';
import '../sources/remote/order_api.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi _orderApi;
  
  OrderRepositoryImpl(this._orderApi);
  
  @override
  Future<List<Order>> getOrders() async {
    try {
      final response = await _orderApi.getOrders();
      final List<dynamic> data = response['orders'] as List<dynamic>;
      return data
          .map((json) => Order.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw OrderRepositoryException('Error al obtener pedidos: $e');
    }
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    try {
      final response = await _orderApi.createOrder(order.toJson());
      return Order.fromJson(response as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw OrderRepositoryException('Error al crear pedido: $e');
    }
  }
  
  Exception _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return OrderRepositoryException('Tiempo de conexión agotado. Verifica tu conexión a internet.');
      case DioExceptionType.connectionError:
        return OrderRepositoryException('No se pudo conectar al servidor. Verifica tu conexión.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Error del servidor';
        return OrderRepositoryException('Error $statusCode: $message');
      case DioExceptionType.cancel:
        return OrderRepositoryException('Solicitud cancelada');
      default:
        return OrderRepositoryException('Error de red: ${e.message}');
    }
  }
}

class OrderRepositoryException implements Exception {
  final String message;
  OrderRepositoryException(this.message);
  
  @override
  String toString() => message;
}

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> createOrder(Order order);
}