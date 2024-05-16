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
        backgroundColor: colorBlueLight,
        title: Text("Detail", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 6),
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 1.3, spreadRadius: 2.3, offset: Offset(1, 3))]),
            child: Table(
              columnWidths: const {0: FixedColumnWidth(100), 1: FixedColumnWidth(20)},
              children: [
                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                TableRow(children: [
                  const Text("Issue Code", style: TextStyle(fontSize: 16)),
                  const Text(":", style: TextStyle(fontSize: 16)),
                  Text(data['issue_code'], style: const TextStyle(fontSize: 16))
                ]),
                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                TableRow(children: [
                  const Text("Wo Code", style: TextStyle(fontSize: 16)),
                  const Text(":", style: TextStyle(fontSize: 16)),
                  Text(data['wo_code'], style: const TextStyle(fontSize: 16))
                ]),
              ],
            ),
          ),
          const SizedBox(height: 6),
          BlocBuilder<GetInquiryDetailCubit, GetInquiryDetailState>(
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
              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var a = data[index];
                    return Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 1.3, spreadRadius: 2.3, offset: Offset(1, 3))]),
                        child: ListTile(
                          title: Text(a.ptDesc!),
                          subtitle: Text(a.lotSerial!),
                          trailing: Text(a.qtyIssue.toString() + " KG", style: TextStyle(fontSize: 14)),
                        ));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
