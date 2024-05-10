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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: ListView(
        children: [
          const Center(
            child: Text("DELTAKOD-KP", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 30),
          CustomTile(
            onTap: () {
              Navigator.pushNamed(context, woScreen);
            },
            color: colorBlueLight,
            leading: const Icon(Icons.menu, color: Colors.white),
            title: const Text("WO ISSUE", style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
          CustomTile(
            onTap: () {
              Navigator.pushNamed(context, inputConsumableScreen);
            },
            color: colorBlueNavy,
            leading: const Icon(Icons.menu, color: Colors.white),
            title: const Text("Consumable ISSUE", style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
          CustomTile(
            onTap: () {
              Navigator.pushNamed(context, inputInventoryScreen);
            },
            color: colorGreenDark,
            leading: const Icon(Icons.menu, color: Colors.white),
            title: const Text("Inventory ISSUE", style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
          const SizedBox(height: 10),
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
