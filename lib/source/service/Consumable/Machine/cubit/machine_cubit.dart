import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableMachineList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:meta/meta.dart';

part 'machine_state.dart';

class MachineCubit extends Cubit<MachineState> {
  final RepositoryConsumable? repository;
  MachineCubit({this.repository}) : super(MachineInitial());

  void machine(id, context) {
    emit(MachineLoading());
    repository!.getMachineList(id, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("MACHINE: $json");
      emit(MachineLoaded(statusCode: statusCode, model: modelConsumableMachineListFromJson(json)));
    });
  }
}
