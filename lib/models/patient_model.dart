import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String? name;
  final String? id;
  final double? height;
  final double? weight;
  final String? address;
  final String? phone;
  final String? gender;
  final Timestamp? birthday;
  final ProcedureType? procedureType;
  final String? currentProcedureId;
  // final String? room;
  const Patient({
    this.name = '',
    this.id = '',
    this.height = 0.0,
    this.weight = 0.0,
    this.address = '',
    this.phone = '',
    this.gender = '',
    this.birthday,
    this.procedureType = ProcedureType.unknown,
    this.currentProcedureId = '',
  });

  Patient copyWith({
    String? name,
    String? id,
    double? height,
    double? weight,
    String? address,
    String? phone,
    String? gender,
    Timestamp? birthday,
    ProcedureType? procedureType,
  }) {
    return Patient(
      name: name ?? this.name,
      id: id ?? this.id,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      procedureType: procedureType ?? this.procedureType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'height': height,
      'weight': weight,
      'address': address,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'procedureType': procedureType.toString().split('.').last,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String?,
      name: map['name'] as String?,
      height: map['height'] as double?,
      weight: map['weight'] as double?,
      address: map['address'] as String?,
      phone: map['phone'] as String?,
      birthday: map['birthday'] as Timestamp?,
      gender: map['gender'] as String?,
      procedureType: ProcedureType.values.firstWhere(
          (e) => e.toString().split('.').last == map['ProcedureType']),
      // room: map['room'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        weight,
        address,
        phone,
        birthday,
        procedureType,
      ];
}
