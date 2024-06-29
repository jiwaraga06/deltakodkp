part of '../../index.dart';

class InputWoScreen extends StatefulWidget {
  const InputWoScreen({super.key});

  @override
  State<InputWoScreen> createState() => _InputWoScreenState();
}

class _InputWoScreenState extends State<InputWoScreen> {
  TextEditingController controllerWoMrCode = TextEditingController();
  TextEditingController controllerWoCode = TextEditingController();
  TextEditingController controllerDate = TextEditingController(text: dateNow);
  TextEditingController controllerBarcode = TextEditingController();
  TextEditingController controllerCari = TextEditingController();
  var woiOid, woiCode, enId, branchId, ccId, woId, woOid, locId, locDesc;
  // result scan qr
  var wodOid, ptId, ptDesc1, lotSerial, qtyIssue;
  final formkey = GlobalKey<FormState>();
  bool isScanMRCode = true;
  void changeStatusScanMRCode() {
    setState(() {
      isScanMRCode = !isScanMRCode;
      controllerWoMrCode.clear();
    });
  }

  void clearAllData() {
    setState(() {
      controllerBarcode.clear();
      inputwo.clear();
      controllerWoMrCode.clear();
      controllerWoCode.clear();
      controllerDate.clear();
      woiOid = null;
      woiCode = null;
      enId = null;
      branchId = null;
      ccId = null;
      woId = null;
      woOid = null;
      locId = null;
      locDesc = null;
      wodOid = null;
      ptId = null;
      ptDesc1 = null;
      lotSerial = null;
      qtyIssue = null;
    });
  }

  void scanQRWoCode() {
    // BlocProvider.of<MaterialRequestCubit>(context).getMaterialReq(context);
  }

  void scanQr() {
    if (controllerWoCode.value.text.isNotEmpty && (locId != null)) {
      BlocProvider.of<QrCubit>(context).qr(controllerWoMrCode.text, controllerBarcode.text, locId, context);
    }
  }

  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerLot = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  void addDetail(desc, lot) {
    setState(() {
      controllerDesc.text = desc;
      controllerLot.text = lot;
      if (inputwo.where((e) => e.lotSerial == lotSerial).isEmpty) {
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
                                inputwo.add(ModelInputWo(
                                    wodOid: wodOid,
                                    ptId: ptId,
                                    ptDesc1: ptDesc1,
                                    locId: locId,
                                    locDesc: locDesc,
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

  void selectDate() {
    pickDate(context).then((date) {
      setState(() {
        controllerDate = TextEditingController(text: date.toString().split(" ")[0]);
      });
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      MyDialog.dialogInfo(context, "Apakah Anda sudah yakin ?", () {}, () {
        BlocProvider.of<InsertWoCubit>(context).insertWo(woiOid, enId, branchId, ccId, woId, woOid, context);
      });
    }
  }

  void clear(value) {
    setState(() {
      inputwo.removeWhere((e) => e.wodOid == value);
    });
  }

  void listenChange() {
    setState(() {
      if ((controllerWoMrCode.text != woiCode) && controllerWoMrCode.text.isNotEmpty) {
        print("ISI: ${controllerWoMrCode.text}");
        BlocProvider.of<MaterialRequestCubit>(context).getMaterialReq(controllerWoMrCode.text, context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<LocationCubit>(context).getLocationList(enId, branchId, context);
    // controllerWoMrCode.addListener(listenChange);
  }

  @override
  void dispose() {
    super.dispose();
    // controllerWoMrCode.removeListener(listenChange);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        clearAllData();
        BlocProvider.of<LocationCubit>(context).initial();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorYellow,
          centerTitle: true,
          title: const Text("ADD NEW WO ISSUE", style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<MaterialRequestCubit, MaterialRequestState>(
              listener: (context, state) {
                if (state is MaterialRequestLoading) {
                  EasyLoading.show();
                }
                if (state is MaterialRequestLoaded) {
                  EasyLoading.dismiss();
                  var data = state.model;
                  var statusCode = state.statusCode;
                  if (statusCode == 200) {
                    setState(() {
                      controllerWoMrCode.text = data!.woiCode!;
                      woiCode = data!.woiCode!;
                      controllerWoCode.text = data!.woCode!;
                      woiOid = data.woiOid;
                      enId = data.enId;
                      branchId = data.branchId;
                      ccId = data.ccId;
                      woId = data.woId;
                      woOid = data.woOid;
                      BlocProvider.of<LocationCubit>(context).getLocationList(enId, branchId, context);
                    });
                  } else {
                    setState(() {
                      controllerWoMrCode.clear();
                    });
                  }
                }
              },
            ),
            BlocListener<QrCubit, QrState>(
              listener: (context, state) {
                if (state is QrLoading) {
                  EasyLoading.show();
                }
                if (state is QrLoaded) {
                  EasyLoading.dismiss();
                  var data = state.model!;
                  var statusCode = state.statusCode;
                  if (statusCode == 200) {
                    setState(() {
                      wodOid = data.wodOid;
                      ptId = data.ptId;
                      ptDesc1 = data.ptDesc1;
                      locId = data.locId;
                      locDesc = data.locDesc;
                      lotSerial = data.lotSerial;
                      qtyIssue = data.qtyIssue;
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
            // SUBMIT
            BlocListener<InsertWoCubit, InsertWoState>(
              listener: (context, state) {
                if (state is InsertWoLoading) {
                  EasyLoading.show();
                }
                if (state is InsertWoLoaded) {
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
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: 6),
                            if (isScanMRCode == true)
                              TextFormField(
                                autofocus: true,
                                controller: controllerWoMrCode,
                                decoration: InputDecoration(
                                  labelText: "MR CODE",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: colorBlack)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          controllerWoMrCode.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear)),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (controllerWoMrCode.text.isNotEmpty) {
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
                                controller: controllerWoMrCode,
                                labelText: "MR Code",
                                hintText: isScanMRCode ? "Scan QR" : "Cari MR Code",
                              ),
                            const SizedBox(height: 8),
                            CustomField(
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerWoCode,
                              labelText: "Nomor WO",
                            ),
                            const SizedBox(height: 8),
                            CustomField(
                              onTap: selectDate,
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerDate,
                              labelText: "Tanggal",
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<LocationCubit, LocationState>(
                              builder: (context, state) {
                                if (state is LocationLoading) {
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: [].map((e) => e).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          hintText: "Location",
                                          labelText: "Location",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                  );
                                }
                                if (state is LocationLoaded == false) {
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: [].map((e) => e).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          hintText: "Location",
                                          labelText: "Location",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                  );
                                }
                                var data = (state as LocationLoaded).model!;
                                var statusCode = (state as LocationLoaded).statusCode;
                                if (statusCode != 200) {
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: [].map((e) => e).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          hintText: "Location",
                                          labelText: "Location",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                  );
                                }
                                return Container(
                                    child: DropdownSearch(
                                  popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                  items: data.map((e) => e.locDesc).toList(),
                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        hintText: "Location",
                                        labelText: "Location",
                                        labelStyle: TextStyle(color: Colors.black),
                                        hintStyle: TextStyle(color: Colors.black)),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      print("disana");
                                      data.where((e) => e.locDesc == value).forEach((a) {
                                        locId = a.locId;
                                        locDesc = a.locDesc;
                                      });
                                    });
                                  },
                                ));
                              },
                            ),
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
                            // CustomButton(
                            //   onTap: scanQr,
                            //   text: "SCAN  QR",
                            //   textStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                            //   bkackgroundColor: colorGreenDarkTeal,
                            // ),
                            const SizedBox(height: 20),
                            if (inputwo.isNotEmpty)
                              Column(
                                children: inputwo.map((e) {
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            clear(e.wodOid);
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
                                        trailing: Text(e.qtyIssue.toString() + " KG"),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
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
    BlocProvider.of<MaterialRequestListCubit>(context).getMaterialReqList(context);
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
                            BlocProvider.of<MaterialRequestListCubit>(context).searchData(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<MaterialRequestListCubit, MaterialRequestListState>(
                  builder: (context, state) {
                    if (state is MaterialRequestListLoading) {
                      return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                    }
                    if (state is MaterialRequestListLoaded == false) {
                      return Container();
                    }
                    var data = (state as MaterialRequestListLoaded).model;
                    var statusCode = (state as MaterialRequestListLoaded).statusCode;
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
                              BlocProvider.of<MaterialRequestCubit>(context).getMaterialReqValue(a.woiCode, context);
                              Navigator.pop(context);
                            },
                            leading: Icon(Icons.format_list_bulleted),
                            title: Text("WOI CODE : ${a.woiCode!}"),
                            subtitle: Text("WO CODE : ${a.woCode!}"),
                          );
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
