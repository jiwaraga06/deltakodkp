part of '../index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool hidePassword = true;

  void showPassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void login() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).login(controllerUsername.text, controllerPassword.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is Authloading) {
            EasyLoading.show();
          }
          if (state is Authloaded) {
            EasyLoading.dismiss();
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              EasyLoading.showSuccess("Login Berhasil !");
              await Future.delayed(const Duration(seconds: 2));
              Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (route) => false);
            } else {
              MyDialog.dialogAlert(context, "Maaf, terjadi kesalahan");
            }
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset("assets/logo_peruri.png", height: 200),
                      ),
                       Text("Welcome !", style: TextStyle(fontSize: 30, color: colorBlueNavy, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 30),
                      CustomField(
                        readOnly: false,
                        hidePassword: false,
                        controller: controllerUsername,
                        hintText: "Masukan Username",
                        labelText: "Username",
                        messageError: "Please insert this column",
                      ),
                      const SizedBox(height: 20),
                      CustomField(
                        readOnly: false,
                        hidePassword: hidePassword,
                        suffixIcon: GestureDetector(
                          onTap: showPassword,
                          child: hidePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        ),
                        controller: controllerPassword,
                        hintText: "Masukan Password",
                        labelText: "Password",
                        messageError: "Please insert this column",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomButton(
                  onTap: login,
                  bkackgroundColor: colorBlueNavy,
                  text: "LOGIN",
                  textStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
