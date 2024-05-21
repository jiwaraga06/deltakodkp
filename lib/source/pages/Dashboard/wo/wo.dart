part of '../../index.dart';

class WoScreen extends StatefulWidget {
  const WoScreen({super.key});

  @override
  State<WoScreen> createState() => _WoScreenState();
}

class _WoScreenState extends State<WoScreen> {
  TextEditingController controllerStartDate = TextEditingController(text: dateNow.toString());
  TextEditingController controllerEndDate = TextEditingController(text: dateNow.toString());
  void getData() {
    BlocProvider.of<GetInquiryCubit>(context).getInquiry(controllerStartDate.text, controllerEndDate.text, context);
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
        backgroundColor: colorYellow,
        centerTitle: true,
        title: const Text("WO ISSUE", style: TextStyle(fontWeight: FontWeight.w500)),
        actions: [IconButton(onPressed: getData, icon: Icon(Icons.refresh))],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 12),
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
                BlocBuilder<GetInquiryCubit, GetInquiryState>(
                  builder: (context, state) {
                    if (state is GetInquiryLoading) {
                      return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                    }
                    if (state is GetInquiryLoaded == false) {
                      return Container();
                    }
                    var data = (state as GetInquiryLoaded).model;
                    var statusCode = (state as GetInquiryLoaded).statusCode;
                    if (data!.isEmpty) {
                      return const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text("Data Kosong"),
                          ));
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        getData();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var a = data[index];
                          return InkWell(
                            splashColor: colorBlueNavy,
                            onTap: () {
                              Navigator.pushNamed(context, detailWoScreen, arguments: {'issue_code': a.issueCode, 'wo_code': a.woCode});
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
                                    const Text("Issue Date", style: TextStyle(fontSize: 15)),
                                    const Text(":", style: TextStyle(fontSize: 15)),
                                    Text(formatDate.format(a.issueDate!), style: const TextStyle(fontSize: 15)),
                                  ]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [
                                    const Text("WO Code", style: TextStyle(fontSize: 15)),
                                    const Text(":", style: TextStyle(fontSize: 15)),
                                    Text(a.woCode!, style: const TextStyle(fontSize: 15)),
                                  ]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [
                                    const Text("Request Code", style: TextStyle(fontSize: 15)),
                                    const Text(":", style: TextStyle(fontSize: 15)),
                                    Text(a.requestCode!, style: const TextStyle(fontSize: 15)),
                                  ]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, inputWoScreen);
                      },
                      text: "ADD NEW WO ISSUE",
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      bkackgroundColor: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          )
        ],
      ),
    );
  }
}
