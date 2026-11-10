import 'package:order_app_client/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> createOrder(Order order);
}