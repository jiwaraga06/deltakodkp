part of '../index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).session(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
      child: CircularProgressIndicator(),
    ));
  }
}
