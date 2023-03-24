import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';
import 'package:promart/promart.dart';

import 'package:logger/logger.dart';

import 'dart:convert';

abstract class IRemoteDataSource {
  /// Fakestore API
  Future<AllProductModel?> getAllProducts({String sort = 'dsc', String? limit});
}

class RemoteDataSource implements IRemoteDataSource {
  Dio _client;

  RemoteDataSource({
    required Dio client,
  }) : _client = client;

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  /// Fakestore API
  @override
  Future<AllProductModel?> getAllProducts(
      {String sort = 'dsc', String? limit}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path:
              'https://fakestoreapi.com/products?sort=$sort&limit=${limit ?? 20}',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllProductModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not load available products');
      }
    }
  }
}
