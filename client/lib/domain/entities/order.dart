part of 'order.g.dart';

@JsonSerializable()
class Order {
  final String id;
  final String customerId;
  final List<OrderItem> items;
  final DateTime createdAt;
  final OrderStatus status;
  final double totalAmount;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.createdAt,
    required this.status,
    required this.totalAmount,
  }) {
    if (id.isEmpty) {
      throw ArgumentError('Order ID cannot be empty');
    }
    if (customerId.isEmpty) {
      throw ArgumentError('Customer ID cannot be empty');
    }
    if (items.isEmpty) {
      throw ArgumentError('Order must contain at least one item');
    }
    if (totalAmount <= 0) {
      throw ArgumentError('Total amount must be positive');
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    String? customerId,
    List<OrderItem>? items,
    DateTime? createdAt,
    OrderStatus? status,
    double? totalAmount,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

@JsonSerializable()
class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  }) {
    if (productId.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }
    if (productName.isEmpty) {
      throw ArgumentError('Product name cannot be empty');
    }
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive');
    }
    if (unitPrice <= 0) {
      throw ArgumentError('Unit price must be positive');
    }
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}