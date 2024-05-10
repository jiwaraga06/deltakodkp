import 'package:deltakodkp/source/env/internetCheck.dart';
import 'package:deltakodkp/source/network/api.dart';
import 'package:deltakodkp/source/network/network.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';

class RepositoryAuth {
  Future login(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.login(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
