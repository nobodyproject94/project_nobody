import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModelSql {
  final int? id;
  final String nama;
  final String email;
  final String noHp;
  final String asalKota;
  UserModelSql({
    this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.asalKota,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'email': email,
      'noHp': noHp,
      'asalKota': asalKota,
    };
  }

  factory UserModelSql.fromMap(Map<String, dynamic> map) {
    return UserModelSql(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      email: map['email'] as String,
      noHp: map['noHp'] as String,
      asalKota: map['asalKota'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelSql.fromJson(String source) =>
      UserModelSql.fromMap(json.decode(source) as Map<String, dynamic>);
}
