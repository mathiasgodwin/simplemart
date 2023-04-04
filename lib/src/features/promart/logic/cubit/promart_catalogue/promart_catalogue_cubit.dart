import 'package:bloc/bloc.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/promart.dart';

part 'promart_catalogue_state.dart';

class PromartCatalogCubit extends Cubit<PromartCatalogState> {
  PromartCatalogCubit(this.repository) : super(const PromartCatalogState());
  final IPromartRepository repository;

  late final _getAllCatalog = GetAllProductUsecase(repository: repository);

  Future<void> loadCatalog({String? sort, String? limit}) async {
    emit(state.copyWith(status: PromartCatalogStatus.loading));
    try {
      final catalog = await _getAllCatalog(sort: sort, limit: limit);
      emit(
        state.copyWith(
          status: PromartCatalogStatus.loaded,
          catalog: catalog,
        ),
      );
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          status: PromartCatalogStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PromartCatalogStatus.failure,
          errorMessage: 'Request could not be made, try again',
        ),
      );
    }
  }
}
