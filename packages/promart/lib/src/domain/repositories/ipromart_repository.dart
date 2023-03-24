import 'package:promart/promart.dart';

abstract class IPromartRepository {
  /// Fakestore API
  Future<AllProductModel?> getAllProducts({String sort = 'dsc', String? limit});
}
