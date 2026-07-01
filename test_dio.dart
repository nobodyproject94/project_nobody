import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://appabsensi.mobileprojp.com',
    ),
  );
  
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    print('URL: ${options.uri}');
    handler.next(options);
  }));
  
  try {
    await dio.get('/api/absen/history');
  } catch (e) {
    if (e is DioException) {
      print('Status: ${e.response?.statusCode}');
    }
  }
}
