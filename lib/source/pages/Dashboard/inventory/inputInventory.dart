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
  TextEditingController controllerBarcode = TextEditingController();
  TextEditingController controllerCari = TextEditingController();
  var enId, branchId, reqOId, reqCode, locid, locdesc, lotSerial;
  var requestDetOid, ptId, ptDesc, plId, umId, qty;
  final formkey = GlobalKey<FormState>();
  bool isScaninventoryCode = true;
  bool isScanQrNonIr = true;
  void listenChange() {
    setState(() {
      if (controllerReqCode.text.isNotEmpty) {
        BlocProvider.of<InventoryRequestCubit>(context).inventoryReq(controllerReqCode.text, context);
      }
    });
  }

  void scanQr() {
    setState(() {
      if (controllerReqCode.text.isNotEmpty) {
        print("ada");
        BlocProvider.of<ScanQrCubit>(context).scanQr(controllerReqCode.text, controllerBarcode.text, locidInv, context);
      } else if (controllerReqCode.text.isEmpty) {
        print("kosong");
        BlocProvider.of<ScanQrNonIrCubit>(context).scanQrNonIr(controllerBarcode.text, locidInv, context);
      }
    });
  }

  void clear(value) {
    setState(() {
      inputInventory.removeWhere((e) => e.lotSerial == value);
    });
  }

  void clearAllData() {
    setState(() {
      BlocProvider.of<InventoryLocationCubit>(context).initial();
      inputInventory.clear();
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
      if (inputInventory.where((e) => e.lotSerial == lotSerial).isEmpty) {
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
                                inputInventory.add(Modelinputinventory(
                                    requestDetOid: requestDetOid,
                                    ptId: ptId,
                                    ptDesc1: ptDesc,
                                    plId: plId,
                                    umId: umId,
                                    locId: locidInv,
                                    locDesc: locDescInv,
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
      BlocProvider.of<InsertInventoryCubit>(context).insert(controllerDate.text, enId, branchId, reqOId, reqCode, context);
    }
  }

  void initial() {
    setState(() {
      enId = 1;
      branchId = 10001;
       BlocProvider.of<InventoryLocationCubit>(context).getLocation(enId, branchId, context);
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
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
          title: const Text("ADD NEW INVENTORY", style: TextStyle(fontWeight: FontWeight.w500)),
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
            ),
            BlocListener<ScanQrNonIrCubit, ScanQrNonIrState>(
              listener: (context, state) {
                if (state is ScanQrNonIrLoading) {
                  EasyLoading.show();
                }
                if (state is ScanQrNonIrLoaded) {
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
            ),
            BlocListener<InsertInventoryCubit, InsertInventoryState>(
              listener: (context, state) {
                if (state is InsertInventoryloading) {
                  EasyLoading.show();
                }
                if (state is InsertInventoryloaded) {
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
                    Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            if (isScaninventoryCode == true)
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
                            if (isScaninventoryCode == false)
                              CustomField(
                                onTap: showModal,
                                readOnly: true,
                                hidePassword: false,
                                controller: controllerReqCode,
                                labelText: "Request Code",
                                hintText: "Cari MR Code",
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
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
