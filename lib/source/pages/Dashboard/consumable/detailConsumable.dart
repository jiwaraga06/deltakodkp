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
          backgroundColor: colorYellow,
        centerTitle: true,
        title: Text("Detail", style: TextStyle(fontWeight: FontWeight.w500)),
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
                  const Text("Req Code", style: TextStyle(fontSize: 16)),
                  const Text(":", style: TextStyle(fontSize: 16)),
                  Text(data['req_code'], style: const TextStyle(fontSize: 16))
                ]),
              ],
            ),
          ),
          const SizedBox(height: 6),
          BlocBuilder<GetInquiryDetailConsumableCubit, GetInquiryDetailConsumableState>(
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
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                        child: ListTile(
                          title: Text(a.ptDesc!),
                          subtitle: Text(a.lotSerial!),
                          trailing: Text(a.qtyIssue.toString() + " " + a.umName!, style: TextStyle(fontSize: 14)),
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
