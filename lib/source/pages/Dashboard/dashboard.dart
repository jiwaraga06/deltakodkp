part of '../index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void logout() {
   MyDialog.dialogInfo(context, "Apakan Anda yakin ingin Logout ?", () { }, () {  BlocProvider.of<AuthCubit>(context).logout(context);});
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Color(0XFFFEB941),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2.3, spreadRadius: 2.3, offset: Offset(2, 3))],
                        gradient: const LinearGradient(colors: [
                          Color(0XFFFEB941),
                          Color(0XFFFF9A00),
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                      ),
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoading) {
                          return Container();
                        }
                        if (state is ProfileLoaded == false) {
                          return Container();
                        }
                        var data = (state as ProfileLoaded).json;
                        return Container(
                          margin: const EdgeInsets.only(left: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hallo ,", style: TextStyle(fontSize: 16)),
                              Text(data['username'].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 80),
                      // height: 200,
                      alignment: Alignment.center,
                      child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset("assets/logo_peruri.png", height: 150)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    crossAxisCount: 3,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, woScreen);
                        },
                        child: Column(
                          children: [
                            Ink(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: colorBlueLight, borderRadius: BorderRadius.circular(8)),
                                child: Icon(Icons.work, color: Colors.white)),
                            SizedBox(height: 10),
                            Text("WO Issue", style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, consumableScreen);
                        },
                        child: Column(
                          children: [
                            Ink(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: colorBlueNavy, borderRadius: BorderRadius.circular(8)),
                                child: Icon(Icons.content_paste_go_rounded, color: Colors.white)),
                            SizedBox(height: 10),
                            Text("Consumable Issue",style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, inventoryScreen);
                        },
                        child: Column(
                          children: [
                            Ink(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: colorGreenDark, borderRadius: BorderRadius.circular(8)),
                                child: Icon(Icons.inventory, color: Colors.white)),
                            SizedBox(height: 10),
                            Text("Inventory Issue",style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: CustomButton(
              bkackgroundColor: Colors.red[800],
              onTap: logout,
              text: "LOGOUT",
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
