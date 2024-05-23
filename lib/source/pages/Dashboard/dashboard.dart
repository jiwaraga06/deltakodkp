part of '../index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void logout() {
    BlocProvider.of<AuthCubit>(context).logout(context);
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
      body: ListView(
        children: [
          Ink(
            color: colorYellow,
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
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
                        margin: const EdgeInsets.only(left: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hallo ,", style: TextStyle(fontSize: 18)),
                            Text(data['username'].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 12),
                    child: Center(
                      child: Text("PT-KP", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
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
                      Text("WO Issue")
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
                      Text("Consumable Issue")
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
                      Text("Inventory Issue")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomButton(
              bkackgroundColor: Colors.red[800],
              onTap: logout,
              text: "LOGOUT",
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
