import 'package:dio/dio.dart';
import 'dart:convert';

void main() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://appabsensi.mobileprojp.com',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  try {
    // 1. Login
    print('Logging in...');
    final loginRes = await dio.post('/api/login', data: {
      'email': 'padil@gmail.com', // Using user's email
      'password': 'password', // Default password? Let's hope it works. Or maybe it fails.
    });
    
    final token = loginRes.data['token'];
    print('Token: $token');
    dio.options.headers['Authorization'] = 'Bearer $token';

    // 2. Fetch Profile
    final profile1 = await dio.get('/api/profile');
    print('Profile before: ${profile1.data['data']}');

    // 3. Update Profile
    final updateRes = await dio.put('/api/profile', data: {
      'name': 'sydney revised',
      'email': 'padil@gmail.com',
      'jenis_kelamin': 'L',
      'batch_id': 2,
      'training_id': 2,
    });
    print('Update Profile Response: ${updateRes.data}');

    // 4. Fetch Profile Again
    final profile2 = await dio.get('/api/profile');
    print('Profile after: ${profile2.data['data']}');

  } catch (e) {
    if (e is DioException) {
      print('DioError: ${e.response?.statusCode} - ${e.response?.data}');
    } else {
      print('Error: $e');
    }
  }
}
