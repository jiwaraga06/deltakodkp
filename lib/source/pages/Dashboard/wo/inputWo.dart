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
  TextEditingController controllerCari = TextEditingController(text: dateNow);
  var woiOid, woiCode, enId, branchId, ccId, woId, woOid, locId, locDesc;
  // result scan qr
  var wodOid, ptId, ptDesc1, lotSerial, qtyIssue;
  final formkey = GlobalKey<FormState>();
  bool isScanMRCode = true;
  void changeStatusScanMRCode() {
    setState(() {
      isScanMRCode = !isScanMRCode;
    });
  }

  void clearAllData() {
    setState(() {
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
    BlocProvider.of<MaterialRequestCubit>(context).getMaterialReq(context);
  }

  void scanQr() {
    if (controllerWoCode.value.text.isNotEmpty && locId != null) {
      BlocProvider.of<QrCubit>(context).qr(controllerWoMrCode.text, locId, context);
    }
  }

  void addDetail() {
    setState(() {
      if (inputwo.where((e) => e.wodOid == wodOid).isEmpty) {
        inputwo.add(ModelInputWo(wodOid: wodOid, ptId: ptId, ptDesc1: ptDesc1, locId: locId, locDesc: locDesc, lotSerial: lotSerial, qtyIssue: qtyIssue));
      } else {
        MyDialog.dialogAlert(context, "Maaf QR ini sudah discan");
      }
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<InsertWoCubit>(context).insertWo(woiOid, enId, branchId, ccId, woId, woOid, context);
    }
  }

  void clear(value) {
    setState(() {
      inputwo.removeWhere((e) => e.wodOid == value);
    });
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<LocationCubit>(context).getLocationList(enId, branchId, context);
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
          title: const Text("Input WO Issue"),
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
                      controllerWoCode.text = data!.woCode!;
                      woiOid = data.woiOid;
                      enId = data.enId;
                      branchId = data.branchId;
                      ccId = data.ccId;
                      woId = data.woId;
                      woOid = data.woOid;
                      BlocProvider.of<LocationCubit>(context).getLocationList(enId, branchId, context);
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
                      addDetail();
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
                          onTap: isScanMRCode ? scanQRWoCode : showModal,
                          readOnly: true,
                          hidePassword: false,
                          controller: controllerWoMrCode,
                          labelText: "MR Code",
                          hintText: isScanMRCode ? "Scan QR" : "Cari MR Code",
                        ),
                        const SizedBox(height: 20),
                        CustomField(
                          readOnly: true,
                          hidePassword: false,
                          controller: controllerWoCode,
                          labelText: "Nomor WO",
                        ),
                        const SizedBox(height: 20),
                        CustomField(
                          readOnly: true,
                          hidePassword: false,
                          controller: controllerDate,
                          labelText: "Tanggal",
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<LocationCubit, LocationState>(
                          builder: (context, state) {
                            if (state is LocationLoading) {
                              return DropdownMenu(
                                  expandedInsets: const EdgeInsets.symmetric(horizontal: 1),
                                  inputDecorationTheme: InputDecorationTheme(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    constraints: BoxConstraints.tight(const Size.fromHeight(50)),
                                    border: const OutlineInputBorder(),
                                  ),
                                  hintText: "Pilih Lokasi",
                                  dropdownMenuEntries: [].map((e) {
                                    return DropdownMenuEntry(value: e, label: e!);
                                  }).toList());
                            }
                            if (state is LocationLoaded == false) {
                              return DropdownMenu(
                                  expandedInsets: const EdgeInsets.symmetric(horizontal: 1),
                                  inputDecorationTheme: InputDecorationTheme(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    constraints: BoxConstraints.tight(const Size.fromHeight(50)),
                                    border: const OutlineInputBorder(),
                                  ),
                                  hintText: "Pilih Lokasi",
                                  dropdownMenuEntries: [].map((e) {
                                    return DropdownMenuEntry(value: e, label: e!);
                                  }).toList());
                            }
                            var data = (state as LocationLoaded).model;
                            var statusCode = (state as LocationLoaded).statusCode;
                            if (statusCode != 200) {
                              return DropdownMenu(
                                  expandedInsets: const EdgeInsets.symmetric(horizontal: 1),
                                  inputDecorationTheme: InputDecorationTheme(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    constraints: BoxConstraints.tight(const Size.fromHeight(50)),
                                    border: const OutlineInputBorder(),
                                  ),
                                  hintText: "Pilih Lokasi",
                                  dropdownMenuEntries: [].map((e) {
                                    return DropdownMenuEntry(value: e, label: e!);
                                  }).toList());
                            }
                            return Container(
                              child: DropdownMenu(
                                expandedInsets: const EdgeInsets.symmetric(horizontal: 1),
                                inputDecorationTheme: InputDecorationTheme(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                  constraints: BoxConstraints.tight(const Size.fromHeight(50)),
                                  border: const OutlineInputBorder(),
                                ),
                                hintText: "Pilih Lokasi",
                                dropdownMenuEntries: data!.map((e) {
                                  return DropdownMenuEntry(value: e, label: e.locDesc!);
                                }).toList(),
                                onSelected: (value) {
                                  setState(() {
                                    print(value);
                                    locId = value!.locId;
                                    locDesc = value!.locDesc;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          onTap: scanQr,
                          text: "SCAN QR",
                          textStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                          bkackgroundColor: colorGreenDarkTeal,
                        ),
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
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
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
