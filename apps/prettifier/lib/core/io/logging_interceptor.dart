import 'package:dio/dio.dart';
import 'package:prettifier/core/utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  late final _logger = LoggerFactory.getLogger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info('REQUEST URI: ${options.uri}');
    _logger.info(
      'METHOD: ${options.method}\nHEADERS: ${options.headers}\nBODY: ${options.data}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;
    _logger.info('RESPONSE URI: ${options.uri}');
    _logger.info(
      'METHOD: ${options.method}\nHEADERS: ${options.headers}\nSTATUS CODE: ${response.statusCode}\nSTATUS MESSAGE: ${response.statusMessage}\nBODY: ${options.data}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final response = err.response;

    _logger.error('URI: ${options.uri}');
    _logger.error(
      'METHOD: ${options.method}\nHEADERS: ${options.headers}\nSTATUS CODE: ${response?.statusCode}\nSTATUS MESSAGE: ${response?.statusMessage}\nBODY: ${options.data}',
    );
    super.onError(err, handler);
  }
}
