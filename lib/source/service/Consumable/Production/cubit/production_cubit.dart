import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableLocationList.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableProductionUnitList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:meta/meta.dart';

part 'production_state.dart';

class ProductionCubit extends Cubit<ProductionState> {
  final RepositoryConsumable? repository;
  ProductionCubit({this.repository}) : super(ProductionInitial());

  void production(id, context) {
    emit(ProductionLoading());
    repository!.getProductionUnitList(id, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("PRODUCTION : $json");
      emit(ProductionLoaded(statusCode: statusCode, model: modelConsumableProductionUnitListFromJson(json)));
    });
  }
}
