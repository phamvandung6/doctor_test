import 'package:doctor_test/utils/enums/enum.dart';
import 'package:doctor_test/utils/enums/enum_to_enum.dart';
import 'package:doctor_test/utils/enums/enum_to_string.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Patient extends Equatable {
  final String id;
  final String name;
  final double weight;
  final double height;
  final DateTime birthday;
  final String address;
  final String phone;
  final String gender;
  ProcedureType procedureType;
  String currentProcedureId;

  Patient({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.gender,
    this.procedureType = ProcedureType.unknown,
    this.currentProcedureId = 'Unknown',
  });

  Patient copyWith({
    String? id,
    String? name,
    double? weight,
    double? height,
    DateTime? birthday,
    String? address,
    String? phone,
    String? gender,
    ProcedureType? procedureType,
    String? currentProcedureId,

  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      procedureType: procedureType ?? this.procedureType,
      currentProcedureId: currentProcedureId ?? this.currentProcedureId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'birthday': birthday.millisecondsSinceEpoch,
      'address': address,
      'phone': phone,
      'gender': gender,
      'procedureType': EnumToString.enumToString(procedureType),
      'currentProcedureId': currentProcedureId,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String,
      name: map['name'] as String,
      weight: map['weight'] as double,
      height: map['height'] as double,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      address: map['address'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      procedureType: StringToEnum.stringToProcedureType(map['procedureType']),
      currentProcedureId: map['currentProcedureId'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      weight,
      height,
      birthday,
      address,
      phone,
      gender,
      procedureType,
      currentProcedureId,
    ];
  }
}
