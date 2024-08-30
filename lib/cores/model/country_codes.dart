// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CountryCode {
  final String name;
  final String code;
  final String dialCode;

  CountryCode({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  CountryCode copyWith({
    String? name,
    String? code,
    String? dialCode,
  }) {
    return CountryCode(
      name: name ?? this.name,
      code: code ?? this.code,
      dialCode: dialCode ?? this.dialCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'dialCode': dialCode,
    };
  }

  factory CountryCode.fromMap(Map<String, dynamic> map) {
    return CountryCode(
      name: map['name'] as String,
      code: map['code'] as String,
      dialCode: map['dial_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryCode.fromJson(String source) =>
      CountryCode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CountryCode(name: $name, code: $code, dialCode: $dialCode)';

  @override
  bool operator ==(covariant CountryCode other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.code == code &&
        other.dialCode == dialCode;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ dialCode.hashCode;
}
