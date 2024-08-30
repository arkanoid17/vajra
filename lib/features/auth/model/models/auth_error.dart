// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthError {
  final String message;
  final String status;

  AuthError({
    required this.message,
    required this.status,
  });

  AuthError copyWith({
    String? message,
    String? status,
  }) {
    return AuthError(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
    };
  }

  factory AuthError.fromMap(Map<String, dynamic> map) {
    return AuthError(
      message: map['message'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthError.fromJson(String source) =>
      AuthError.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthError(message: $message, status: $status)';

  @override
  bool operator ==(covariant AuthError other) {
    if (identical(this, other)) return true;

    return other.message == message && other.status == status;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode;
}
