import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Patient extends Equatable {
  final String id;
  final String name;
  final double weight;
  final double height;
  final Timestamp birthday;
  final String address;
  final String phone;
  final String gender;

  const Patient({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.gender,
  });

  Patient copyWith({
    String? id,
    String? name,
    double? weight,
    double? height,
    Timestamp? birthday,
    String? address,
    String? phone,
    String? gender,
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'birthday': birthday,
      'address': address,
      'phone': phone,
      'gender': gender,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String,
      name: map['name'] as String,
      weight: map['weight'] as double,
      height: map['height'] as double,
      birthday: map['birthday'] as Timestamp,
      address: map['address'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
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
    ];
  }
}
