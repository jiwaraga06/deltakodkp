part of '../../index.dart';

class DetailWoScreen extends StatefulWidget {
  const DetailWoScreen({super.key});

  @override
  State<DetailWoScreen> createState() => _DetailWoScreenState();
}

class _DetailWoScreenState extends State<DetailWoScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    BlocProvider.of<GetInquiryDetailCubit>(context).getInquiryDetail(data['issue_code'], context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: BlocBuilder<GetInquiryDetailCubit, GetInquiryDetailState>(
        builder: (context, state) {
          if (state is GetInquiryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetInquiryDetailLoaded == false) {
            return Container();
          }
          var data = (state as GetInquiryDetailLoaded).model;
          var statusCode = (state as GetInquiryDetailLoaded).statusCode;
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
                      const Text("WO Code", style: TextStyle(fontSize: 17)),
                      const Text(":", style: TextStyle(fontSize: 17)),
                      Text(a.woCode!, style: const TextStyle(fontSize: 17)),
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
