import 'package:deltakodkp/source/repository/repositoryAuth.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:deltakodkp/source/router/router.dart';
import 'package:deltakodkp/source/service/Auth/cubit/auth_cubit.dart';
import 'package:deltakodkp/source/service/Wo/GetInquiry/cubit/get_inquiry_cubit.dart';
import 'package:deltakodkp/source/service/Wo/GetInquiryDetail/cubit/get_inquiry_detail_cubit.dart';
import 'package:deltakodkp/source/service/Wo/MateriaReqList/cubit/material_request_list_cubit.dart';
import 'package:deltakodkp/source/service/Wo/MaterialReq/cubit/material_request_cubit.dart';
import 'package:deltakodkp/source/service/Wo/Qr/cubit/qr_cubit.dart';
import 'package:deltakodkp/source/service/Wo/insert/cubit/insert_wo_cubit.dart';
import 'package:deltakodkp/source/service/Wo/location/cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp(router: RouterNavigation()));
}

class MyApp extends StatelessWidget {
  RouterNavigation? router;
  MyApp({super.key, this.router});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RepositoryAuth()),
        RepositoryProvider(create: (context) => RepositoryWo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(repository: RepositoryAuth())),
          // WO
          BlocProvider(create: (context) => GetInquiryCubit(repository: RepositoryWo())),
          BlocProvider(create: (context) => GetInquiryDetailCubit(repository: RepositoryWo())),
          BlocProvider(create: (context) => MaterialRequestCubit(repository: RepositoryWo())),
          BlocProvider(create: (context) => MaterialRequestListCubit(repository: RepositoryWo())),
          BlocProvider(create: (context) => LocationCubit(repository: RepositoryWo())),
          BlocProvider(create: (context) => QrCubit(repository: RepositoryWo())),
          BlocProvider(create: (context) => InsertWoCubit(repository: RepositoryWo())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: Color(0XFF10439F), // warna oranye
              secondary: Color(0XFF10439F), // warna biru tua
              surface: Colors.white, // warna putih
              background: Colors.white, // warna putih
              error: Color(0XFFC40C0C), // warna merah untuk kesalahan
              onPrimary: Colors.white, // warna teks pada latar belakang utama
              onSecondary: Color(0XFF10439F), // warna teks pada latar belakang sekunder
              onSurface: Colors.black, // warna teks pada permukaan
              onBackground: Colors.black, // warna teks pada latar belakang
              onError: Colors.red, // warna teks untuk kesalahan
              brightness: Brightness.light, // mode terang
            ),
            useMaterial3: true,
          ),
          builder: EasyLoading.init(),
          onGenerateRoute: router!.generateRoute,
        ),
      ),
    );
  }
}
