import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:meta/meta.dart';

part 'insert_consumable_state.dart';

class InsertConsumableCubit extends Cubit<InsertConsumableState> {
  final RepositoryConsumable? repository;
  InsertConsumableCubit({this.repository}) : super(InsertConsumableInitial());

  void insertConsumbale(context)async {
    var body = {};
    print(body);
  }

}
