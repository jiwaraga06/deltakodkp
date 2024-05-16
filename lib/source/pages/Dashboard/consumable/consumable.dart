part of '../../index.dart';

class ConsumableScreen extends StatefulWidget {
  const ConsumableScreen({super.key});

  @override
  State<ConsumableScreen> createState() => _ConsumableScreenState();
}

class _ConsumableScreenState extends State<ConsumableScreen> {
  TextEditingController controllerStartDate = TextEditingController(text: dateNow.toString());
  TextEditingController controllerEndDate = TextEditingController(text: dateNow.toString());
  void getData() {
    BlocProvider.of<GetInquiryConsumableCubit>(context).getInquiry(controllerStartDate.text, controllerEndDate.text, context);
  }

  void pickStartDate() {
    pickDate(context).then((value) {
      if (value != null) {
        var date = DateFormat('yyyy-MM-dd').format(value);
        print(date);
        controllerStartDate.text = date;
        getData();
      }
    });
  }

  void pickEndDate() {
    pickDate(context).then((value) {
      if (value != null) {
        var date = DateFormat('yyyy-MM-dd').format(value);
        controllerEndDate.text = date;
        print(date);
        getData();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlueNavy,
        title: Text("Consumable", style: TextStyle(color: Colors.white)), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            onTap: () {
              Navigator.pushNamed(context, inputConsumableScreen);
            },
            text: "Input Consumable",
            textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            bkackgroundColor: Colors.teal,
          ),
        )
      ]),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: CustomField(
                  controller: controllerStartDate,
                  onTap: pickStartDate,
                  readOnly: true,
                  hidePassword: false,
                  labelText: "Pilih Tanggal Awal",
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: CustomField(
                  controller: controllerEndDate,
                  onTap: pickEndDate,
                  readOnly: true,
                  hidePassword: false,
                  labelText: "Pilih Tanggal Akhir",
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<GetInquiryConsumableCubit, GetInquiryConsumableState>(
            builder: (context, state) {
              if (state is GetInquiryConsumableLoading) {
                return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
              }
              if (state is GetInquiryConsumableLoaded == false) {
                return Container();
              }
              var data = (state as GetInquiryConsumableLoaded).model;
              if (data!.isEmpty) {
                return const SizedBox(
                  height: 100,
                  child: Center(child: Text("Data Kosong")),
                );
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    getData();
                  },
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var a = data[index];
                      return InkWell(
                        splashColor: colorBlueNavy,
                        onTap: () {
                          Navigator.pushNamed(context, detailConsumableScreen, arguments: {'issue_code': a.issueCode,'req_code': a.requestCode });
                        },
                        child: Container(
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
                                const Text("Issue Code", style: TextStyle(fontSize: 16)),
                                const Text(":", style: TextStyle(fontSize: 16)),
                                Text(a.issueCode!, style: const TextStyle(fontSize: 16)),
                              ]),
                              const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                              TableRow(children: [
                                const Text("Req Code", style: TextStyle(fontSize: 15)),
                                const Text(":", style: TextStyle(fontSize: 15)),
                                Text(a.requestCode!, style: const TextStyle(fontSize: 15)),
                              ]),
                              const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                              TableRow(children: [
                                const Text("Issue Date", style: TextStyle(fontSize: 15)),
                                const Text(":", style: TextStyle(fontSize: 15)),
                                Text(a.issueDate.toString(), style: const TextStyle(fontSize: 15)),
                              ]),
                              const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
