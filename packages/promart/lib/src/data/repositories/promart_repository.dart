import 'package:logger/logger.dart';
import 'package:promart/promart.dart';

class PromartRepository implements IPromartRepository {
  PromartRepository({
    required IRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  final IRemoteDataSource _dataSource;

  /// Fakestore API
  @override
  Future<AddCartModel?> addCart({required AddCartModel carts}) async {
    try {
      final response = await _dataSource.addCart(carts: carts);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteCartModel?> deleteCart({required String cartId}) async {
    try {
      final response = await _dataSource.deleteCart(cartId: cartId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleUserModel?> deleteUser({required String userId}) async {
    try {
      final response = await _dataSource.deleteUser(userId: userId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllCartModel?> getAllCarts(
      {String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _dataSource.getAllCarts(limit: limit, sort: sort);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllCategoryModel?> getAllCategory() async {
    try {
      final response = await _dataSource.getAllCategory();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllProductModel?> getAllProducts(
      {String sort = 'dsc', String? limit}) async {
    try {
      final response =
          await _dataSource.getAllProducts(sort: sort, limit: limit);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllUserModel?> getAllUsers() async {
    try {
      final response = await _dataSource.getAllUsers();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _dataSource.getCategoryProduct(
          category: category, limit: limit, sort: sort);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleCartModel?> getSingleCart({required String cartId}) async {
    try {
      final response = await _dataSource.getSingleCart(cartId: cartId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleProductModel?> getSingleProduct(
      {required String productId}) async {
    try {
      final response = await _dataSource.getSingleProduct(productId: productId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleUserModel?> getSingleUser({required String userId}) async {
    try {
      final response = await _dataSource.getSingleUser(userId: userId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AllCartModel?> getUserCart({required String userId}) async {
    try {
      final response = await _dataSource.getUserCart(userId: userId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginTokenModel?> loginUser(
      {required String password, required String username}) async {
    try {
      final response =
          await _dataSource.loginUser(password: password, username: username);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleUserModel?> registerUser({required SingleUserModel user}) async {
    try {
      final response = await _dataSource.registerUser(user: user);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SingleUserModel?> updateUser({required SingleUserModel user}) async {
    try {
      final response = await _dataSource.updateUser(user: user);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
