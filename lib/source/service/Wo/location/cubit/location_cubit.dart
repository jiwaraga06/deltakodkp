import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelLocationlist.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final RepositoryWo? repository;
  LocationCubit({this.repository}) : super(LocationInitial());

  void initial() {
    emit(LocationInitial());
  }

  void getLocationList(enId, branchId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    print(enId);
    print(branchId);
    print("username $username");
    emit(LocationLoading());
    repository!.getLocationList(enId, branchId, username, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Location: $json");
      emit(LocationLoaded(statusCode: statusCode, model: modelLocationListFromJson(json)));
    });
  }
}
