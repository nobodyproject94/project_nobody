import 'package:dio/dio.dart';
import 'package:project_nobody/day_1/models/ghibli.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

// 1. Ubah Base URL ke Ghibli API
@RestApi(baseUrl: 'https://ghibliapi.vercel.app')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 2. Ubah endpoint ke /films
  @GET('/films')
  // 3. Ubah nama class modelnya ke Ghibli (sesuaikan dengan nama class di file ghibli.dart lu)
  Future<List<Ghibli>> getFilms();
}
