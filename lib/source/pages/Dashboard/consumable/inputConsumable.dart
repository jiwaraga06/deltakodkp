part of '../../index.dart';

class InputConsumableScreen extends StatefulWidget {
  const InputConsumableScreen({super.key});

  @override
  State<InputConsumableScreen> createState() => _InputConsumableScreenState();
}

class _InputConsumableScreenState extends State<InputConsumableScreen> {
  TextEditingController controllerReqCode = TextEditingController();
  TextEditingController controllerInventory = TextEditingController();
  TextEditingController controllerDate = TextEditingController(text: dateNow);
  TextEditingController controllerCari = TextEditingController(text: dateNow);
  var enId, branchId, reqOId, reqCode, prodId, prodname, machineId, machineName, locid, locname;
  var requestDetOid, ptId, ptDesc, plId, umid, locdesc, lotSerial, qty;
  final formkey = GlobalKey<FormState>();
  bool isScanMRCode = true;

  void scanQrReqCode() {
    BlocProvider.of<InventoryReqCubit>(context).inventoryReq(context);
  }

  void scanQr() {
    print(loclocationCid);
    print(loclocationCDesc);
    BlocProvider.of<ScanQrConsumableCubit>(context).ScanQR(controllerReqCode.text, loclocationCid, context);
  }

  void clear(value) {
    setState(() {
      inputconsumable.removeWhere((e) => e.lotSerial == value);
    });
  }

  void clearAllData() {
    setState(() {
      inputconsumable.clear();
      controllerReqCode.clear();
      controllerInventory.clear();
      requestDetOid = null;
      ptId = null;
      ptDesc = null;
      plId = null;
      umid = null;
      loclocationCid = null;
      loclocationCDesc = null;
      lotSerial = null;
      qty = null;
    });
  }

  void addDetail() {
    setState(() {
      // if (inputconsumable.where((e) => e.wodOid == wodOid).isEmpty) {
      inputconsumable.add(ModelinputConsumable(
          requestDetOid: requestDetOid,
          ptId: ptId,
          ptDesc1: ptDesc,
          plId: plId,
          umId: umid,
          locId: loclocationCid,
          locDesc: loclocationCDesc,
          lotSerial: lotSerial,
          qtyIssue: qty));
      // } else {
      //   MyDialog.dialogAlert(context, "Maaf QR ini sudah discan");
      // }
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<InsertConsumableCubit>(context).insertConsumbale(controllerDate.text, enId, branchId, reqOId, reqCode, prodId, machineId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Consumable"),
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
          BlocListener<InventoryReqCubit, InventoryReqConsumableState>(
            listener: (context, state) {
              if (state is InventoryReqConsumableloading) {
                EasyLoading.show();
              }
              if (state is InventoryReqConsumableloaded) {
                EasyLoading.dismiss();
                var data = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  setState(() {
                    controllerReqCode.text = data.requestCode!;
                    enId = data.enId;
                    branchId = data.branchId;
                    prodId = data.prodUnitId;
                    machineId = data.prodMachineId;
                    reqOId = data.requestOid;
                    reqCode = data.requestCode;
                    BlocProvider.of<ProductionCubit>(context).production(data.enId, context);
                    BlocProvider.of<MachineCubit>(context).machine(data.enId, context);
                    BlocProvider.of<LocationConsumableCubit>(context).getLocation(data.enId, data.branchId, context);
                  });
                }
              }
            },
          ),
          BlocListener<ProductionCubit, ProductionState>(
            listener: (context, state) {
              if (state is ProductionLoading) {}
              if (state is ProductionLoaded) {
                var data = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  print("disini");
                  setState(() {
                    data.where((e) => e.prodUnitId == prodId).forEach((a) {
                      prodname = a.prodUnitName;
                    });
                  });
                }
              }
            },
          ),
          BlocListener<MachineCubit, MachineState>(
            listener: (context, state) {
              if (state is MachineLoading) {}
              if (state is MachineLoaded) {
                var data = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  print("disini");
                  setState(() {
                    data.where((e) => e.prodMachineId == machineId).forEach((a) {
                      machineName = a.prodMachineName;
                    });
                  });
                }
              }
            },
          ),
          BlocListener<LocationConsumableCubit, LocationConsumableState>(
            listener: (context, state) {
              if (state is LocationConsumableLoading) {}
              if (state is LocationConsumableLoaded) {
                var data = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  // data.where((e) => e.locDesc == locId).forEach((a) {
                  //   locname = a.locDesc;
                  // });
                  // print(locId);
                }
              }
            },
          ),
          BlocListener<ScanQrConsumableCubit, ScanQrConsumableState>(
            listener: (context, state) {
              if (state is ScanQrConsumableLoading) {
                EasyLoading.show();
              }
              if (state is ScanQrConsumableLoaded) {
                EasyLoading.dismiss();
                var data = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  setState(() {
                    requestDetOid = data.requestDetOid;
                    ptId = data.ptId;
                    ptDesc = data.ptDesc1;
                    plId = data.plId;
                    umid = data.umId;
                    lotSerial = data.lotSerial;
                    qty = data.qtyIssue;
                    addDetail();
                  });
                }
              }
            },
          ),
          BlocListener<InsertConsumableCubit, InsertConsumableState>(
            listener: (context, state) {
              if (state is InsertConsumableloading) {
                EasyLoading.show();
              }
              if (state is InsertConsumableloaded) {
                EasyLoading.dismiss();
                var data = state.json;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  clearAllData();
                  MyDialog.dialogSuccess(context, "Berhasil !");
                } else if (statusCode == 401) {
                  MyDialog.dialogInfo(context, "Authorisasi habis, silahkan login kembali", () {
                    Navigator.of(context).pop();
                  }, () {
                    Navigator.of(context).pop();
                  });
                } else {
                  MyDialog.dialogAlert(context, data['message']);
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
                      Text("Metode Input MR Code"),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const SizedBox(width: 6),
                          if (isScanMRCode)
                            Text("SCAN QR", style: TextStyle(fontWeight: FontWeight.w500))
                          else
                            Text("CARI DATA", style: TextStyle(fontWeight: FontWeight.w500)),
                          const SizedBox(width: 10),
                          Switch(
                            value: isScanMRCode,
                            onChanged: (value) {
                              setState(() {
                                isScanMRCode = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      CustomField(
                        onTap: isScanMRCode ? scanQrReqCode : showModal,
                        readOnly: true,
                        hidePassword: false,
                        controller: controllerReqCode,
                        labelText: "Request Code",
                        hintText: isScanMRCode ? "Scan QR" : "Cari MR Code",
                      ),
                      const SizedBox(height: 20),
                      ProductionUnit(prodId: prodId, prodName: prodname),
                      const SizedBox(height: 20),
                      Machine(machineId: machineId, machineName: machineName),
                      const SizedBox(height: 20),
                      CustomField(
                        readOnly: true,
                        hidePassword: false,
                        controller: controllerDate,
                        labelText: "Tanggal",
                      ),
                      const SizedBox(height: 20),
                      LocationConsumable(locId: locid, locDesc: locdesc),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: scanQr,
                        text: "SCAN QR",
                        textStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                        bkackgroundColor: colorGreenDarkTeal,
                      ),
                      const SizedBox(height: 20),
                      if (inputconsumable.isNotEmpty)
                        Column(
                          children: inputconsumable.map((e) {
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
                                          SizedBox(
                                            height: 40,
                                            child: TextFormField(
                                              initialValue: e.qtyIssue.toString(),
                                              keyboardType: TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value.isNotEmpty) {
                                                    e.qtyIssue = int.parse(value);
                                                  } else {
                                                    print('kosong');
                                                    e.qtyIssue = 0;
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical: 10)),
                                            ),
                                          )
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void showModal() {
    BlocProvider.of<InventoryReqListCubit>(context).inventoryReqList(context);
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
                            BlocProvider.of<InventoryReqListCubit>(context).searchData(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<InventoryReqListCubit, InventoryReqConsumableListState>(
                  builder: (context, state) {
                    if (state is InventoryReqConsumableListLoading) {
                      return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                    }
                    if (state is InventoryReqConsumableListLoaded == false) {
                      return Container();
                    }
                    var data = (state as InventoryReqConsumableListLoaded).model;
                    var statusCode = (state as InventoryReqConsumableListLoaded).statusCode;
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
                                BlocProvider.of<InventoryReqCubit>(context).inventoryReqValue(a.requestCode, context);
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
