import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:promart/src/data/data.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class MockRequestOptions extends Mock implements RequestOptions {}

void main() {
  const endpoint = 'https://fakestoreapi.com/products';

  late MockDio dioClient;
  late RemoteDataSource remoteDataSource;
  late Future<Response<dynamic>> response;

  setUp(() {
    dioClient = MockDio();
    registerFallbackValue(MockRequestOptions());

    remoteDataSource = RemoteDataSource(
      client: dioClient,
    );
    response = Future.value(
      Response(
          requestOptions: RequestOptions(
            queryParameters: {'sort': 'desc', 'limit': 20},
            path: endpoint,
          ),
          data: [
            [
              {
                "id": 1,
                "title":
                    "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                "price": 109.95,
                "description":
                    "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                "category": "men's clothing",
                "image":
                    "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                "rating": {
                  "rate": 3.9,
                  "count": 120,
                }
              }
            ]
          ]),
    );
  });

  group('get all Products', () {
    test('dio.fetch() method must be called', () async {
      /// Arrange
      when(() => dioClient.fetch(any()))
          .thenAnswer(((realInvocation) => response));

      /// Act
      await remoteDataSource.getAllProducts(sort: 'desc', limit: '20');

      /// Assert
      verify(
        () => dioClient.fetch(any()),
      ).called(1);
    });
  });
}
