import 'package:dio/dio.dart';
import 'package:project_nobody/day_1/models/auth_resnponse.dart';
import 'package:project_nobody/day_1/models/profile_response.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: 'https://absensib1.mobileprojp.com')
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST('/api/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @GET('/api/profile')
  Future<ProfileResponse> getProfile();

  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(@Body() Map<String, dynamic> body);
}
