import 'package:dio/dio.dart';

class OrderApi {
  final Dio _dio;
  static const String _baseUrl = 'http://<load_balancer_dns>/api';
  
  OrderApi(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (object) => print('[OrderApi] $object'),
    ));
  }
  
  Future<Map<String, dynamic>> getOrders() async {
    try {
      final response = await _dio.get('/orders');
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _enhanceError(e);
    }
  }
  
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _dio.post('/orders', data: orderData);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _enhanceError(e);
    }
  }
  
  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode != null && 
        response.statusCode! >= 200 && 
        response.statusCode! < 300) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return {'data': response.data};
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Respuesta inesperada: ${response.statusCode}',
    );
  }
  
  DioException _enhanceError(DioException e) {
    String message;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Tiempo de conexión agotado';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Tiempo de envío agotado';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Tiempo de recepción agotado';
        break;
      case DioExceptionType.connectionError:
        message = 'Error de conexión: no se pudo conectar al servidor';
        break;
      case DioExceptionType.badResponse:
        message = 'Error del servidor: ${e.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        message = 'Solicitud cancelada';
        break;
      default:
        message = e.message ?? 'Error desconocido';
    }
    return DioException(
      requestOptions: e.requestOptions,
      response: e.response,
      type: e.type,
      error: e.error,
      message: message,
    );
  }
}