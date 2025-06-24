// import 'package:dio/dio.dart';

// class Api {
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://dummyjson.com/',
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 60),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     ),
//   );

//   // GET
//   static Future<dynamic> get(
//     String endpoint, {
//     Map<String, dynamic>? queryParams,
//   }) async {
//     try {
//       final response = await _dio.get(endpoint, queryParameters: queryParams);
//       return response.data;
//     } on DioException catch (e) {
//       throw Exception('GET Error: ${e.response?.data ?? e.message}');
//     }
//   }

//   // POST
//   static Future<dynamic> post(
//     String endpoint,
//     Map<String, dynamic> data,
//   ) async {
//     try {
//       final response = await _dio.post(endpoint, data: data);
//       return response.data;
//     } on DioException catch (e) {
//       throw Exception('POST Error: ${e.response?.data ?? e.message}');
//     }
//   }
// }
