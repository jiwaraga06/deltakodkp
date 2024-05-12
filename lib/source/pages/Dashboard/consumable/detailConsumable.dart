part of '../../index.dart';

class DetailConsumableScreen extends StatefulWidget {
  const DetailConsumableScreen({super.key});

  @override
  State<DetailConsumableScreen> createState() => _DetailConsumableScreenState();
}

class _DetailConsumableScreenState extends State<DetailConsumableScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    BlocProvider.of<GetInquiryDetailConsumableCubit>(context).getInquiryDetail(data['issue_code'], context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: BlocBuilder<GetInquiryDetailConsumableCubit, GetInquiryDetailConsumableState>(
        builder: (context, state) {
          if (state is GetInquiryDetailConsumableLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetInquiryDetailConsumableLoaded == false) {
            return Container();
          }
          var data = (state as GetInquiryDetailConsumableLoaded).model;
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
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: colorBlack, width: 1), borderRadius: BorderRadius.circular(8.0)),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(20),
                  },
                  children: [
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("PT", style: TextStyle(fontSize: 19)),
                      const Text(":", style: TextStyle(fontSize: 19)),
                      Text(a.ptDesc!, style: const TextStyle(fontSize: 19)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Issue Code", style: TextStyle(fontSize: 17)),
                      const Text(":", style: TextStyle(fontSize: 17)),
                      Text(a.issueCode!, style: const TextStyle(fontSize: 17)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Req  Code", style: TextStyle(fontSize: 17)),
                      const Text(":", style: TextStyle(fontSize: 17)),
                      Text(a.requestCode!, style: const TextStyle(fontSize: 17)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("Lot Serial", style: TextStyle(fontSize: 17)),
                      const Text(":", style: TextStyle(fontSize: 17)),
                      Text(a.lotSerial!, style: const TextStyle(fontSize: 17)),
                    ]),
                    const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                    TableRow(children: [
                      const Text("QTY", style: TextStyle(fontSize: 17)),
                      const Text(":", style: TextStyle(fontSize: 17)),
                      Row(
                        children: [
                          Text(a.qtyIssue.toString(), style: const TextStyle(fontSize: 17)),
                          const SizedBox(width: 10),
                          Text(a.umName!, style: const TextStyle(fontSize: 17)),
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
