import 'package:promart/promart.dart';

class PromartRepository implements IPromartRepository {
  PromartRepository({
    required IRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  final IRemoteDataSource _dataSource;

  /// Fakestore API
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
}
