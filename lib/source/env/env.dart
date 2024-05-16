import 'package:deltakodkp/source/model/Consumable/modelinputConsumable.dart';
import 'package:deltakodkp/source/model/Inventory/modelinputInventory.dart';
import 'package:deltakodkp/source/model/Wo/modelInputWo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const host = "http://131183204125.ip-dynamic.com:8082";

const colorBlack = Color(0XFF222831);
const colorBlueGrey = Color(0XFF3C5B6F);
const colorBlueLight = Color(0XFF40A2E3);
const colorBlueNavy = Color(0XFF0C2D57);
const colorGreenDark = Color(0XFF50623A);
const colorGreenDarkTeal = Color(0XFF0A6847);

// date
var formatDate = DateFormat('yyyy-MM-dd');
var formatDateWithHour = DateFormat('yyyy-MM-dd hh:mm:ss');
var dateNow = DateTime.now().toString().split(' ')[0];

// MODEL INPUT WO
List<ModelInputWo> inputwo = [];
List<ModelInputWo> selectedInputwo = [];
// MODEL INPUT Consumable
List<ModelinputConsumable> inputconsumable = [];
List<ModelinputConsumable> selectedInputconsumable = [];
var loclocationCid, loclocationCDesc;
var prodId,prodname, machineId, machinename ;
var locidInv, locDescInv;
// Model Input Inventory
List<Modelinputinventory> inputInventory = [];
