// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/logic/time_controller/medical_range.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:equatable/equatable.dart';

import 'medical_action/medical_check_glucose.dart';
import 'medical_action/medical_take_insulin.dart';

// ignore: must_be_immutable
class Regimen extends Equatable {
  //1. attributes
  String name;
  List<dynamic> medicalActions;
  DateTime beginTime;
  num startingPoint = 0;
  Regimen({
    required this.name,
    required this.medicalActions,
    required this.beginTime,
    this.startingPoint = 0,
  });
  //1.1. compare
  //props
  @override
  List<Object> get props => [name, medicalActions, beginTime, startingPoint];

  //2. methods add
  void addMedicalAction(dynamic medicalAction) {
    medicalActions.add(medicalAction.clone());
  }

  //3. print for debug
  @override
  String toString() {
    dynamic medicalactionsStr = medicalActions.toString();
    return '''Regimen name: $name, 
              beginTime: $beginTime,
               $medicalactionsStr
    ''';
  }

  //4. convert data
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'medicalActions': medicalActions,
      'beginTime': beginTime.millisecondsSinceEpoch,
      'startingPoint': startingPoint,
    };
  }

  factory Regimen.fromMap(Map<String, dynamic> map) {
    return Regimen(
      name: map['name'] as String,
      medicalActions:
          List<dynamic>.from((map['medicalActions'] as List<dynamic>)),
      beginTime: DateTime.fromMillisecondsSinceEpoch(map['beginTime'] as int),
      startingPoint: map['startingPoint'] as num,
    );
  }

  //from snapshot
  factory Regimen.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return Regimen.fromMap(map);
  }
  
  Regimen clone() {
    return Regimen(
      medicalActions: [for (dynamic x in medicalActions) x.clone()],
      name: name,
      beginTime: beginTime,
      startingPoint: startingPoint,
    );
  }

  //6. get data
  List<MedicalCheckGlucose> get medicalCheckGlucoses {
    List<MedicalCheckGlucose> list = [];
    for (var x in medicalActions) {
      if (x is MedicalCheckGlucose) list.add(x);
    }
    return list;
  }

  List<MedicalTakeInsulin> get medicalTakeInsulins {
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin) list.add(x);
    }
    return list;
  }

  //medical take actrapid insulin
  List<MedicalTakeInsulin> get medicalTakeActrapidInsulins {
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin && x.insulinType == InsulinType.actrapid) {
        list.add(x);
      }
    }
    return list;
  }

  //medical take not actrapid insulin
  List<MedicalTakeInsulin> get medicalTakeNotActrapidInsulins {
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin && x.insulinType != InsulinType.actrapid) {
        list.add(x);
      }
    }
    return list;
  }

  get lastNotActrapidInsulinTime {
    if (medicalTakeNotActrapidInsulins.isEmpty) return DateTime(1999);
    return medicalTakeNotActrapidInsulins.last.time;
  }

  //get last
  num get lastGluAmount {
    if (medicalCheckGlucoses.isEmpty) return 0;
    return medicalCheckGlucoses.last.glucoseUI;
  }

  DateTime get lastGluTime {
    if (medicalCheckGlucoses.isEmpty) return DateTime(1999);
    return medicalCheckGlucoses.last.time;
  }

  //get last actrapid insulin
  DateTime get lastActrapidInsulinTime {
    if (medicalTakeActrapidInsulins.isEmpty) return DateTime(1999);
    return medicalTakeActrapidInsulins.last.time;
  }

  RegimenStatus regimenSlowStatus(MedicalRange medicalRange) {
    if (!medicalRange.isHot(lastNotActrapidInsulinTime)) {
      return RegimenStatus.givingInsulin;
    }
    return RegimenStatus.done;
  }

  RegimenStatus regimenActrapidStatus(MedicalRange medicalRange) {
    if (!medicalRange.isHot(lastGluTime)) return RegimenStatus.checkingGlucose;
    if (!medicalRange.isHot(lastActrapidInsulinTime)) {
      return RegimenStatus.givingInsulin;
    }
    return RegimenStatus.done;
  }

  bool get isFull50 {
    int counter = 0;
    for (var x in medicalCheckGlucoses) {
      if (x.glucoseUI > 8.3) counter++;
    }
    return counter >= 5;
  }

  DateTime get lastTime {
    if (medicalActions.isEmpty) return beginTime;
    return medicalActions.last.time;
  }

  DateTime get firstTime {
    return beginTime;
  }

  Regimen copyWith({
    String? name,
    List<dynamic>? medicalActions,
    DateTime? beginTime,
    num? startingPoint,
  }) {
    return Regimen(
      name: name ?? this.name,
      medicalActions: medicalActions ?? this.medicalActions,
      beginTime: beginTime ?? this.beginTime,
      startingPoint: startingPoint ?? this.startingPoint,
    );
  }

  String toJson() => json.encode(toMap());

  factory Regimen.fromJson(String source) =>
      Regimen.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

Regimen initialRegimen() {
  return Regimen(
    beginTime: DateTime.now(),
    medicalActions: const [],
    name: 'Unknown',
  );
}

Regimen errorRegimen() {
  return Regimen(
    beginTime: DateTime.now(),
    medicalActions: const [],
    name: 'Error',
  );
}
