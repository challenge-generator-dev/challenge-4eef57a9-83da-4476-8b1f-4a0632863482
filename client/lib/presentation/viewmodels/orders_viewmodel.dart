import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/create_order.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/sources/remote/order_api.dart';
import 'package:dio/dio.dart';

class OrdersState {
  final List<Order> orders;
  final bool isLoading;
  final String? error;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrdersState copyWith({
    List<Order>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class OrdersViewModel extends StateNotifier<OrdersState> {
  final GetOrders _getOrders;
  final CreateOrder _createOrder;

  OrdersViewModel(this._getOrders, this._createOrder) : super(const OrdersState());

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final orders = await _getOrders();
      state = state.copyWith(orders: orders, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapDioError(e),
      );
    } on Exception catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  Future<bool> createOrder(Order order) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createdOrder = await _createOrder(order);
      state = state.copyWith(
        orders: [...state.orders, createdOrder],
        isLoading: false,
      );
      return true;
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapDioError(e),
      );
      return false;
    } on Exception catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error inesperado: ${e.toString()}',
      );
      return false;
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado. Verifica tu conexión a internet.';
      case DioExceptionType.sendTimeout:
        return 'Tiempo de envío agotado. Intenta de nuevo.';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de espera de respuesta agotado. Intenta de nuevo.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return 'No autorizado. Inicia sesión nuevamente.';
        } else if (statusCode == 403) {
          return 'Acceso denegado.';
        } else if (statusCode == 404) {
          return 'Recurso no encontrado.';
        } else if (statusCode != null && statusCode >= 500) {
          return 'Error del servidor. Intenta más tarde.';
        }
        return 'Error en la respuesta del servidor.';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada.';
      case DioExceptionType.connectionError:
        return 'Error de conexión. Verifica tu conexión a internet.';
      default:
        return 'Error de red: ${e.message}';
    }
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://<load_balancer_dns>/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    error: true,
  ));

  return dio;
});

final orderApiProvider = Provider<OrderApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderApi(dio);
});

final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {
  final api = ref.watch(orderApiProvider);
  return OrderRepositoryImpl(api);
});

final getOrdersProvider = Provider<GetOrders>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrders(repository);
});

final createOrderProvider = Provider<CreateOrder>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CreateOrder(repository);
});

final ordersViewModelProvider = StateNotifierProvider<OrdersViewModel, OrdersState>((ref) {
  final getOrders = ref.watch(getOrdersProvider);
  final createOrder = ref.watch(createOrderProvider);
  return OrdersViewModel(getOrders, createOrder);
});