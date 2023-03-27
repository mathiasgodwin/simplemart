import 'package:mocktail/mocktail.dart';
import 'package:promart/src/data/data.dart';
import 'package:promart/src/domain/domain.dart';
import 'package:test/scaffolding.dart';

class MockPromartRepository extends Mock implements PromartRepository {}

void main() {
  late GetAllProductUsecase usecase;
  late MockPromartRepository mockRepository;

  setUp(() {
    mockRepository = MockPromartRepository();
    usecase = GetAllProductUsecase(repository: mockRepository);
  });

  test('Should get all products', () async {
    // Arrange
    when(
      () => mockRepository.getAllProducts(
        sort: any(named: 'sort'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((invocation) => Future.value(AllProductModel(data: [])));

    // Act
    try {
      await usecase(sort: 'desc', limit: '20');
    } catch (_) {}

    verify(
      () => mockRepository.getAllProducts(sort: 'desc', limit: '20'),
    ).called(1);
  });
}
