import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../../domain/entities/order.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerIdController = TextEditingController();
  final List<_OrderItemForm> _items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersViewModelProvider.notifier).loadOrders();
    });
  }

  @override
  void dispose() {
    _customerIdController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _addItem() {
    setState(() {
      _items.add(_OrderItemForm());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un producto al pedido')),
      );
      return;
    }

    final orderItems = _items.map((item) => OrderItem(
      productId: item.productIdController.text,
      productName: item.productNameController.text,
      quantity: int.tryParse(item.quantityController.text) ?? 1,
      unitPrice: double.tryParse(item.priceController.text) ?? 0.0,
    )).toList();

    final totalAmount = orderItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.quantity * item.unitPrice),
    );

    final order = Order(
      id: '',
      customerId: _customerIdController.text,
      items: orderItems,
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
      totalAmount: totalAmount,
    );

    final success = await ref.read(ordersViewModelProvider.notifier).createOrder(order);
    if (success && mounted) {
      _customerIdController.clear();
      for (final item in _items) {
        item.clear();
      }
      setState(() {
        _items.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido creado exitosamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ordersViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? _buildErrorView(state.error!)
              : _buildContent(state.orders),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateOrderDialog,
        tooltip: 'Crear pedido',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error al cargar pedidos',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(ordersViewModelProvider.notifier).loadOrders();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay pedidos aún',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Toca el botón + para crear tu primer pedido',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(ordersViewModelProvider.notifier).loadOrders();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(order: order);
        },
      ),
    );
  }

  void _showCreateOrderDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _CreateOrderForm(
          formKey: _formKey,
          customerIdController: _customerIdController,
          items: _items,
          scrollController: scrollController,
          onAddItem: _addItem,
          onRemoveItem: _removeItem,
          onSubmit: _submitOrder,
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => _showOrderDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${order.id.substring(0, 8)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _StatusChip(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    order.customerId,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(order.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.items.length} producto(s)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pedido #${order.id.substring(0, 8)}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(label: 'Cliente', value: order.customerId),
              _DetailRow(label: 'Estado', value: order.status.name),
              _DetailRow(label: 'Fecha', value: _formatDate(order.createdAt)),
              const Divider(),
              const Text('Productos:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...order.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• ${item.productName} x${item.quantity} (\$${(item.quantity * item.unitPrice).toStringAsFixed(2)})'),
              )),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _StatusChip extends StatelessWidget {
  final OrderStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case OrderStatus.pending:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
      case OrderStatus.confirmed:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
      case OrderStatus.shipped:
        backgroundColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
      case OrderStatus.delivered:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
      case OrderStatus.cancelled:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _statusLabel(status),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _OrderItemForm {
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1');
  final TextEditingController priceController = TextEditingController();

  void dispose() {
    productIdController.dispose();
    productNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }

  void clear() {
    productIdController.clear();
    productNameController.clear();
    quantityController.text = '1';
    priceController.clear();
  }
}

class _CreateOrderForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController customerIdController;
  final List<_OrderItemForm> items;
  final ScrollController scrollController;
  final VoidCallback onAddItem;
  final void Function(int) onRemoveItem;
  final VoidCallback onSubmit;

  const _CreateOrderForm({
    required this.formKey,
    required this.customerIdController,
    required this.items,
    required this.scrollController,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nuevo Pedido',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: customerIdController,
              decoration: const InputDecoration(
                labelText: 'ID Cliente',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa el ID del cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Productos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: onAddItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _ItemFormCard(
                    index: index,
                    item: items[index],
                    onRemove: () => onRemoveItem(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Crear Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemFormCard extends StatelessWidget {
  final int index;
  final _OrderItemForm item;
  final VoidCallback onRemove;

  const _ItemFormCard({
    required this.index,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Producto ${index + 1}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: item.productIdController,
              decoration: const InputDecoration(
                labelText: 'ID Producto',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: item.productNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: item.quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requerido';
                      }
                      if (int.tryParse(value) == null || int.parse(value) < 1) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: item.priceController,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requerido';
                      }
                      if (double.tryParse(value) == null || double.parse(value) < 0) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}