import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';
import 'package:promart/promart.dart';

import 'package:logger/logger.dart';

import 'dart:convert';

abstract class IRemoteDataSource {
  /// Fakestore API
  Future<AllProductModel?> getAllProducts({String sort = 'dsc', String? limit});

  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'});

  Future<AllCartModel?> getAllCarts({String? limit, String sort = 'dsc'});

  Future<AllCartModel?> getUserCart({required String userId});

  Future<AllCategoryModel?> getAllCategory();

  Future<AllUserModel?> getAllUsers();

  Future<SingleProductModel?> getSingleProduct({required String productId});

  Future<SingleCartModel?> getSingleCart({required String cartId});

  Future<SingleUserModel?> getSingleUser({required String userId});

  Future<DeleteCartModel?> deleteCart({required String cartId});

  Future<LoginTokenModel?> loginUser(
      {required String password, required String username});

  Future<AddCartModel?> addCart({required AddCartModel carts});

  //
  Future<SingleUserModel?> registerUser({required SingleUserModel user});

  Future<SingleUserModel?> updateUser({required SingleUserModel user});

  Future<SingleUserModel?> deleteUser({required String userId});
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
  Future<AddCartModel?> addCart({required AddCartModel carts}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts',
          method: 'POST',
          data: carts.toMap(),
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
        return AddCartModel.fromJson(response.data);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Add to cart Error');
      }
    }
  }

  @override
  Future<DeleteCartModel?> deleteCart({required String cartId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts/$cartId',
          method: 'DELETE',
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
        return DeleteCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Delete Cart Error');
      }
    }
  }

  @override
  Future<SingleUserModel?> deleteUser({required String userId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users/$userId',
          method: 'DELETE',
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
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Delete user error');
      }
    }
  }

  @override
  Future<AllCartModel?> getAllCarts(
      {String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts',
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
        return AllCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Get All carts error');
      }
    }
  }

  @override
  Future<AllCategoryModel?> getAllCategory() async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/products/categories',
          method: 'GET',
          sendTimeout: 10000 ~/ 2,
          receiveTimeout: 10000 ~/ 2,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        return AllCategoryModel.fromJson(response.data);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Get all category error');
      }
    }
  }

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

  @override
  Future<AllUserModel?> getAllUsers() async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users',
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
        return AllUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Error getting users');
      }
    }
  }

  @override
  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path:
              'https://fakestoreapi.com/products/category/$category?sort=$sort ${limit == null ? '' : '&limit=' + limit}',
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
        throw Exception('Could not send request');
      }
    }
  }

  @override
  Future<SingleCartModel?> getSingleCart({required String cartId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts/$cartId',
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
        return SingleCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request, check connection');
      }
    }
  }

  @override
  Future<SingleProductModel?> getSingleProduct(
      {required String productId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/products/$productId',
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
        return SingleProductModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request');
      }
    }
  }

  @override
  Future<SingleUserModel?> getSingleUser({required String userId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users/$userId',
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
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Unable to send request');
      }
    }
  }

  @override
  Future<AllCartModel?> getUserCart({required String userId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts/user/$userId',
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
        return AllCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('The request was unsuccessful, try again!');
      }
    }
  }

  @override
  Future<LoginTokenModel?> loginUser(
      {required String password, required String username}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/auth/login',
          data: json.encode({'username': username, 'password': password}),
          method: 'POST',
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
        return LoginTokenModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Login error');
      }
    }
  }

  @override
  Future<SingleUserModel?> registerUser({required SingleUserModel user}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users',
          method: 'POST',
          data: user.toMap(),
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
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not make request');
      }
    }
  }

  @override
  Future<SingleUserModel?> updateUser({required SingleUserModel user}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users',
          method: 'PUT',
          data: user.toMap(),
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
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request');
      }
    }
  }
}
