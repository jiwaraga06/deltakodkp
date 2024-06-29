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
  TextEditingController controllerCari = TextEditingController();
  TextEditingController controllerBarcode = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  var enId, branchId, reqOId, reqCode, locid, locname;
  var requestDetOid, ptId, ptDesc, plId, umid, locdesc, lotSerial, qty;
  final formkey = GlobalKey<FormState>();
  bool isScanMRCode = true;

  void scanQrReqCode() {
    // BlocProvider.of<InventoryReqCubit>(context).inventoryReq(context);
  }

  void scanQr() {
    print(loclocationCid);
    print(loclocationCDesc);
    if (controllerReqCode.text.isNotEmpty && (loclocationCid != null)) {
      BlocProvider.of<ScanQrConsumableCubit>(context).scanQR(controllerReqCode.text, controllerBarcode.text, loclocationCid, context);
    }
  }

  void clear(value) {
    setState(() {
      inputconsumable.removeWhere((e) => e.lotSerial == value);
    });
  }

  void clearAllData() {
    setState(() {
      BlocProvider.of<ProductionCubit>(context).initial();
      BlocProvider.of<MachineCubit>(context).initial();
      BlocProvider.of<LocationConsumableCubit>(context).initial();
      inputconsumable.clear();
      controllerBarcode.clear();
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

  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerLot = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  void addDetail(desc, lot) {
    setState(() {
      controllerLot.text = lot;
      controllerDesc.text = desc;
      if (inputconsumable.where((e) => e.lotSerial == lot).isEmpty) {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text("Add To Detail", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          const SizedBox(height: 10),
                          CustomField(
                            controller: controllerDesc,
                            readOnly: true,
                            hidePassword: false,
                            labelText: "Item Description",
                          ),
                          const SizedBox(height: 10),
                          CustomField(
                            controller: controllerLot,
                            readOnly: true,
                            hidePassword: false,
                            labelText: "Lot Serial",
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            controller: controllerQty,
                            decoration: InputDecoration(
                              labelText: "QTY",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: colorBlack)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        CustomButton(
                          onTap: () {
                            if (controllerQty.text.isEmpty || controllerQty.text == "0") {
                              MyDialog.dialogAlert(context, "Kolom QTY tidak boleh 0 atau kosong");
                            } else {
                              setState(() {
                                inputconsumable.add(ModelinputConsumable(
                                    requestDetOid: requestDetOid,
                                    ptId: ptId,
                                    ptDesc1: ptDesc,
                                    plId: plId,
                                    umId: umid,
                                    locId: loclocationCid,
                                    locDesc: loclocationCDesc,
                                    lotSerial: lotSerial,
                                    qtyIssue: num.parse(controllerQty.text)));
                                controllerQty.clear();
                                controllerDesc.clear();
                                controllerLot.clear();
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          bkackgroundColor: Colors.blue[700],
                          text: "Add To Detail",
                          textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          bkackgroundColor: Colors.red[700],
                          text: "Cancel",
                          textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      } else {
        MyDialog.dialogAlert(context, "Maaf QR ini sudah discan");
      }
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      MyDialog.dialogInfo(context, "Apakah Anda sudah yakin ?", () {}, () {
        BlocProvider.of<InsertConsumableCubit>(context)
            .insertConsumbale(controllerDate.text, enId, branchId, reqOId, reqCode, prodId, machineId, controllerKeterangan.text, context);
      });
    }
  }
 void selectDate() {
    pickDate(context).then((date) {
      setState(() {
        controllerDate = TextEditingController(text: date.toString().split(" ")[0]);
      });
    });
  }
  void listenChange() {
    setState(() {
      if ((controllerReqCode.text != reqCode) && controllerReqCode.text.isNotEmpty) {
        print("ISI: ${controllerReqCode.text}");
        BlocProvider.of<InventoryReqCubit>(context).inventoryReq(controllerReqCode.text, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<LocationCubit>(context).getLocationList(enId, branchId, context);
    controllerReqCode.addListener(listenChange);
  }

  @override
  void dispose() {
    super.dispose();
    controllerReqCode.removeListener(listenChange);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        clearAllData();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorYellow,
          centerTitle: true,
          title: const Text("Add New Consumable", style: TextStyle(fontWeight: FontWeight.w500)),
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
                  } else {
                    setState(() {
                      controllerReqCode.clear();
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
                        machinename = a.prodMachineName;
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
                      addDetail(data.ptDesc1, data.lotSerial);
                    });
                  } else {
                    setState(() {
                      controllerBarcode.clear();
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
                    MyDialog.dialogSuccess(context, data['message']);
                  } else if (statusCode == 401) {
                    MyDialog.dialogInfo(context, "Authorisasi habis, silahkan login kembali", () {
                      Navigator.of(context).pop();
                    }, () {
                      Navigator.of(context).pop();
                    });
                  } else {
                    if (data['message'] != null) {
                      MyDialog.dialogAlert(context, data['message']);
                    } else {
                      MyDialog.dialogAlert(context, data['errors']);
                    }
                  }
                }
              },
            )
          ],
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18.0),
                      child: Row(
                        children: [
                          if (isScanMRCode == true) Text("SCAN BY QR"),
                          if (isScanMRCode == false) Text("SEARCH MR CODE"),
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
                    ),
                    Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            if (isScanMRCode == true)
                              TextFormField(
                                autofocus: true,
                                controller: controllerReqCode,
                                decoration: InputDecoration(
                                  labelText: "REQUEST CODE",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: colorBlack)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          controllerReqCode.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear)),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (controllerReqCode.text.isNotEmpty) {
                                      listenChange();
                                    }
                                  });
                                },
                              ),
                            if (isScanMRCode == false)
                              CustomField(
                                onTap: showModal,
                                readOnly: true,
                                hidePassword: false,
                                controller: controllerReqCode,
                                labelText: "REQUEST Code",
                                hintText: "Cari REQ Code",
                              ),
                            const SizedBox(height: 10),
                            ProductionUnit(),
                            const SizedBox(height: 10),
                            Machine(),
                            const SizedBox(height: 10),
                            CustomField(
                              onTap: selectDate,
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerDate,
                              labelText: "Tanggal",
                            ),
                            const SizedBox(height: 10),
                            LocationConsumable(),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: controllerBarcode,
                              decoration: InputDecoration(
                                labelText: "BARCODE",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        controllerBarcode.clear();
                                      });
                                    },
                                    child: Icon(Icons.clear)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: colorBlack)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (controllerBarcode.text.isNotEmpty) {
                                    scanQr();
                                  }
                                });
                              },
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
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.5),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: ListTile(
                                          title: Text(e.ptDesc1!),
                                          subtitle: Text(e.lotSerial!),
                                          trailing: Text(e.qtyIssue.toString()),
                                        )),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onTap: submit,
                  text: "SAVE",
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  bkackgroundColor: Colors.indigo[600],
                ),
              ),
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
