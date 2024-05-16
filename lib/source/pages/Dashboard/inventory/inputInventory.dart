part of '../../index.dart';

class InputInvetoryScreen extends StatefulWidget {
  const InputInvetoryScreen({super.key});

  @override
  State<InputInvetoryScreen> createState() => _InputInvetoryScreenState();
}

class _InputInvetoryScreenState extends State<InputInvetoryScreen> {
  TextEditingController controllerReqCode = TextEditingController();
  TextEditingController controllerInventory = TextEditingController();
  TextEditingController controllerDate = TextEditingController(text: dateNow);
  TextEditingController controllerCari = TextEditingController();
  var enId, branchId, reqOId, reqCode, locid, locdesc, lotSerial;
  var requestDetOid, ptId, ptDesc, plId, umId, qty;
  final formkey = GlobalKey<FormState>();
  bool isScaninventoryCode = true;
  bool isScanQrNonIr = true;
  void scanQrReqCode() {
    BlocProvider.of<InventoryRequestCubit>(context).inventoryReq(context);
  }

  void scanQr() {
    BlocProvider.of<ScanQrCubit>(context).scanQr(controllerReqCode.text, locidInv, context);
  }

  void scanQrNonIr() {
    BlocProvider.of<ScanQrNonIrCubit>(context).scanQrNonIr(locidInv, context);
  }

  void clear(value) {
    setState(() {
      inputInventory.removeWhere((e) => e.lotSerial == value);
    });
  }

  void clearAllData() {
    setState(() {
      inputconsumable.clear();
      controllerReqCode.clear();
      controllerInventory.clear();
      loclocationCid = null;
      loclocationCDesc = null;
      lotSerial = null;
    });
  }

  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerLot = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  void addDetail(desc, lot) {
    setState(() {
      controllerDesc.text = desc;
      controllerLot.text = lot;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Detail"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    const SizedBox(height: 10),
                    CustomField(controller: controllerDesc, readOnly: true, hidePassword: false, labelText: "Item Description"),
                    const SizedBox(height: 10),
                    CustomField(controller: controllerLot, readOnly: true, hidePassword: false, labelText: "Lot Serial"),
                    const SizedBox(height: 10),
                    CustomField(keyboardType: TextInputType.number, controller: controllerQty, readOnly: false, hidePassword: false, labelText: "QTY"),
                  ]),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Tutup")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      print(locid);
                      print(locdesc);
                      inputInventory.add(Modelinputinventory(
                          locDesc: locdesc,
                          locId: locid,
                          lotSerial: lotSerial,
                          plId: plId,
                          ptDesc1: ptDesc,
                          ptId: ptId,
                          qtyIssue: num.parse(controllerQty.text),
                          requestDetOid: requestDetOid,
                          umId: umId));
                      controllerQty.clear();
                      controllerDesc.clear();
                      controllerLot.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("Add Detail")),
            ],
          );
        },
      );
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<InsertInventoryCubit>(context).insert(controllerDate.text, enId, branchId, reqOId, reqCode, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        clearAllData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Input Inventory"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onTap: submit,
                text: "SAVE",
                textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                bkackgroundColor: Colors.green[600],
              ),
            )
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<InventoryRequestCubit, InventoryReqState>(
              listener: (context, state) {
                if (state is InventoryReqLoading) {
                  EasyLoading.show();
                }
                if (state is InventoryReqLoaded) {
                  EasyLoading.dismiss();
                  var data = state.model!;
                  var statusCode = state.statusCode;
                  if (statusCode == 200) {
                    setState(() {
                      controllerReqCode.text = data.requestCode!;
                      enId = data.enId;
                      branchId = data.branchId;
                      reqOId = data.requestOid;
                      reqCode = data.requestCode;
                      BlocProvider.of<InventoryLocationCubit>(context).getLocation(data.enId, data.branchId, context);
                    });
                  }
                }
              },
            ),
            BlocListener<ScanQrCubit, ScanQrState>(
              listener: (context, state) {
                if (state is ScanQrLoading) {
                  EasyLoading.show();
                }
                if (state is ScanQrLoaded) {
                  EasyLoading.dismiss();
                  var data = state.model!;
                  var statusCode = state.statusCode;
                  if (statusCode == 200) {
                    setState(() {
                      lotSerial = data.lotSerial;
                      requestDetOid = data.requestDetOid;
                      ptId = data.ptId;
                      ptDesc = data.ptDesc1;
                      plId = data.plId;
                      umId = data.umId;
                      qty = data.qtyIssue;
                      addDetail(data.ptDesc1, data.lotSerial);
                    });
                  }
                }
              },
            )
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Metode Input Request Code"),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            if (isScaninventoryCode)
                              Text("SCAN QR", style: TextStyle(fontWeight: FontWeight.w500))
                            else
                              Text("CARI DATA", style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(width: 10),
                            Switch(
                              value: isScaninventoryCode,
                              onChanged: (value) {
                                setState(() {
                                  isScaninventoryCode = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        CustomField(
                          onTap: isScaninventoryCode ? scanQrReqCode : showModal,
                          readOnly: true,
                          hidePassword: false,
                          controller: controllerReqCode,
                          labelText: "Request Code",
                          hintText: isScaninventoryCode ? "Scan QR" : "Cari MR Code",
                        ),
                        const SizedBox(height: 10),
                        Location(locId: locid, locName: locdesc),
                        const SizedBox(height: 10),
                        CustomField(
                          readOnly: true,
                          hidePassword: false,
                          controller: controllerDate,
                          labelText: "Tanggal",
                        ),
                        const SizedBox(height: 20),
                        Text("Metode Scan QR"),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            if (isScanQrNonIr)
                              Text("SCAN QR Non Request Code", style: TextStyle(fontWeight: FontWeight.w500))
                            else
                              Text("SCAN QR Request Code", style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(width: 10),
                            Switch(
                              value: isScanQrNonIr,
                              onChanged: (value) {
                                setState(() {
                                  isScanQrNonIr = value;
                                  locDescInv = "";
                                  locid = 0;
                                });
                              },
                            ),
                          ],
                        ),
                        if (isScanQrNonIr == true)
                          CustomButton(
                            onTap: scanQrNonIr,
                            text: "SCAN QR Non Request Code",
                            textStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                            bkackgroundColor: colorGreenDarkTeal,
                          ),
                        if (isScanQrNonIr == false)
                          CustomButton(
                            onTap: scanQr,
                            text: "SCAN QR Request Code",
                            textStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                            bkackgroundColor: colorBlueNavy,
                          ),
                      ],
                    ),
                  ),
                ),
                if (inputInventory.isNotEmpty)
                  Column(
                    children: inputInventory.map((e) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                clear(e.lotSerial);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(90),
                                  1: FixedColumnWidth(10),
                                },
                                children: [
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [
                                    const Text("PT", style: TextStyle(fontSize: 19)),
                                    const Text(":", style: TextStyle(fontSize: 19)),
                                    Text(e.ptDesc1!, style: const TextStyle(fontSize: 19)),
                                  ]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [
                                    const Text("LOT/SERIAL", style: TextStyle(fontSize: 16)),
                                    const Text(":", style: TextStyle(fontSize: 16)),
                                    Text(e.lotSerial!, style: const TextStyle(fontSize: 16)),
                                  ]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [
                                    const Text("QTY", style: TextStyle(fontSize: 17)),
                                    const Text(":", style: TextStyle(fontSize: 17)),
                                    Text(e.qtyIssue.toString(), style: TextStyle(fontSize: 17)),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModal() {
    BlocProvider.of<InventoryRequestListCubit>(context).inventoryReqList(context);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.close),
                          Text('Tutup'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                          controller: controllerCari,
                          decoration: InputDecoration(hintText: 'Cari Code', prefixIcon: Icon(Icons.search)),
                          onChanged: (value) {
                            BlocProvider.of<InventoryRequestListCubit>(context).inventoryReqListSearch(value, context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<InventoryRequestListCubit, InventoryReqListState>(
                  builder: (context, state) {
                    if (state is InventoryReqListLoading) {
                      return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                    }
                    if (state is InventoryReqListLoaded == false) {
                      return Container();
                    }
                    var data = (state as InventoryReqListLoaded).model;
                    var statusCode = (state as InventoryReqListLoaded).statusCode;
                    if (data!.isEmpty) {
                      return Container();
                    }
                    if (statusCode == 401) {
                      return Container(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Session Habis, silahkan login kembali"),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: "LOGOUT",
                              bkackgroundColor: Colors.red[700],
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).logout(context);
                              },
                            )
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var a = data[index];
                          return ListTile(
                              onTap: () {
                                print(data);
                                BlocProvider.of<InventoryRequestCubit>(context).inventoryReqValue(a.requestCode, context);
                                Navigator.pop(context);
                              },
                              leading: Icon(Icons.format_list_bulleted),
                              title: Text("REQ CODE : ${a.requestCode!}"));
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}
