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
      appBar: AppBar(title: const Text("WO Issue"), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            onTap: (){
              Navigator.pushNamed(context, inputWoScreen);
            },
            text: "Input WO",
            textStyle:const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                  child: Center(child: Text("Data Kosong")),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var a = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, detailWoScreen, arguments: {
                          'issue_code' : a.issueCode
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        decoration:
                            BoxDecoration(color: Colors.white, border: Border.all(color: colorBlack, width: 1), borderRadius: BorderRadius.circular(8.0)),
                        child: Table(
                          columnWidths: const {
                            0: FixedColumnWidth(100),
                            1: FixedColumnWidth(20),
                          },
                          children: [
                            const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                            TableRow(children: [
                              const Text("Issue Code", style: TextStyle(fontSize: 19)),
                              const Text(":", style: TextStyle(fontSize: 19)),
                              Text(a.issueCode!, style: const TextStyle(fontSize: 19)),
                            ]),
                            const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                            TableRow(children: [
                              const Text("Issue Date", style: TextStyle(fontSize: 17)),
                              const Text(":", style: TextStyle(fontSize: 17)),
                              Text(formatDate.format(a.issueDate!), style: const TextStyle(fontSize: 17)),
                            ]),
                            const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                            TableRow(children: [
                              const Text("WO Code", style: TextStyle(fontSize: 17)),
                              const Text(":", style: TextStyle(fontSize: 17)),
                              Text(a.woCode!, style: const TextStyle(fontSize: 17)),
                            ]),
                            const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                            TableRow(children: [
                              const Text("Request Code", style: TextStyle(fontSize: 17)),
                              const Text(":", style: TextStyle(fontSize: 17)),
                              Text(a.requestCode!, style: const TextStyle(fontSize: 17)),
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
          )
        ],
      ),
    );
  }
}
