
import 'package:dio/dio.dart';
import 'package:fl_egypt_trust/models/utils/app_preference.dart';
import 'package:fl_egypt_trust/models/utils/language/languages.dart';
import 'package:fl_egypt_trust/models/utils/themes/themes_bloc/bloc.dart';
import '../../../di/dependency_injection.dart';
import 'dio_interceptor.dart';

class DioClientService {
  String baseUrl = 'https://online.egypttrust.com/Apis/';
   String baseToken="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibW9iaWxlVXNlciIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMDZhYzg0NjQtNjNhOC00ZmYyLTlhZjMtYzhhYTYwNDkzMGJkIiwianRpIjoiYjQyM2UyYmItN2RiYS00ODhkLTk5NTEtNmE4ZTQxNTljZWE1IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiUi0wMDIiLCJleHAiOjE5OTQ2NjI5MDcsImlzcyI6ImVneXB0dHJ1c3QuY29tIiwiYXVkIjoiYXVkaWVuY2UifQ.EXCDb55mthXU1lkl_ofe6AiFdhv7CuC_QPMDPxEFvVI";
  late Dio _dio;
  bool _isUnitTest = false;

  DioClientService({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;
    _dio = _createDio( );
    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Future<String> getNetworkLocal()async{
  String locale= (await sl<AppPreference>().getNetworkLocale()).networkLocalValue();
  if(locale.isNotEmpty)return locale;
  return EnumNetworkLangs.arabic.networkLocalValue();
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Language': getNetworkLocal().toString(),
            // if (AppPreference.instance != null) ...{
            'Authorization':
                'Bearer $baseToken',
            // },
          },
          receiveTimeout:const Duration(seconds: 20),
          connectTimeout:const Duration(seconds: 10),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
    String?token,
    int?receiveTimeOutInMillisecond,
  }) async {
    try {
      return await _dio.get(
          url, queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Language':sl<ThemeBloc>().appLocal,
            // if (AppPreference.instance != null) ...{
            'Authorization':
            'Bearer ${token??baseToken}',
            // },
          },

        ),

      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
        final String?token,
  }) async {
    try {
      return await _dio.post(url, data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Language': "ar-SA",
            // if (AppPreference.instance != null) ...{
            'Authorization':
            'Bearer ${token??baseToken}',            // },
          },

        ),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postForms({
    required String url,
    required FormData data,
  }) async {
    try {
      return await _dio.post(url,
          data: data,
        options: Options(
          headers: {
            "ContentType":"multipart/form-data",
            'Accept': 'multipart/form-data',
            "Accept-Language":"ar-SA",
            'Authorization':
            'Bearer $baseToken',
          }
        )
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> downloadImages({required String url,required String?imagePath})async{
   try{
     return await _dio.download(url,imagePath,
         options: Options(
       headers: {
         "ContentType":"multipart/form-data",
         'Accept': 'multipart/form-data',
         "Accept-Language":getNetworkLocal(),
         'Authorization':
         'Bearer $baseToken',
       }
     )
     );
   }catch(e){
     throw Exception(e);
   }
  }

  Future<Response>updateClientData({required url,required FormData formData})async{
    try{
      return await _dio.put(url,
        data: formData,
        options: Options(
            headers: {
              "ContentType":"multipart/form-data",
              'Accept': 'multipart/form-data',
              "lang":getNetworkLocal(),
              'Authorization':
              'Bearer $baseToken',
            }
        )
      ) ;
    }catch(e){
      throw Exception(e);
    }
  }
}
