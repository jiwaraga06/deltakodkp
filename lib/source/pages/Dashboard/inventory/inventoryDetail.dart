part of '../../index.dart';

class InventoryDetailScreen extends StatefulWidget {
  const InventoryDetailScreen({super.key});

  @override
  State<InventoryDetailScreen> createState() => _InventoryDetailScreenState();
}

class _InventoryDetailScreenState extends State<InventoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    BlocProvider.of<GetInventoryInquiryDetailCubit>(context).getInventoryInquiryDetail(data['issue_code'], context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: BlocBuilder<GetInventoryInquiryDetailCubit, GetInventoryInquiryDetailState>(
        builder: (context, state) {
          if (state is GetInventoryInquiryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetInventoryInquiryDetailLoaded == false) {
            return Container();
          }
          var data = (state as GetInventoryInquiryDetailLoaded).model;
          if (data!.isEmpty) {
            return Center(
              child: Text("Data kosong"),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var a = data[index];
              return Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.only(left: 18, right: 18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(20),
                  },
                  children: [
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Desc", style: TextStyle(fontSize: 16)),
                      const Text(":", style: TextStyle(fontSize: 16)),
                      Text(a.ptDesc!, style: const TextStyle(fontSize: 16)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Issue Code", style: TextStyle(fontSize: 15)),
                      const Text(":", style: TextStyle(fontSize: 15)),
                      Text(a.issueCode!, style: const TextStyle(fontSize: 15)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Req  Code", style: TextStyle(fontSize: 15)),
                      const Text(":", style: TextStyle(fontSize: 15)),
                      Text(a.requestCode!, style: const TextStyle(fontSize: 15)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Lot Serial", style: TextStyle(fontSize: 15)),
                      const Text(":", style: TextStyle(fontSize: 15)),
                      Text(a.lotSerial!, style: const TextStyle(fontSize: 15)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("QTY", style: TextStyle(fontSize: 15)),
                      const Text(":", style: TextStyle(fontSize: 15)),
                      Row(
                        children: [
                          Text(a.qtyIssue.toString(), style: const TextStyle(fontSize: 15)),
                          const SizedBox(width: 10),
                          Text(a.umName!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
