import 'dart:convert';

class CustomException implements Exception {
  final String cause;
  CustomException({
    required this.cause,
  });

  CustomException copyWith({
    String? cause,
  }) {
    return CustomException(
      cause: cause ?? this.cause,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cause': cause,
    };
  }

  factory CustomException.fromMap(Map<String, dynamic> map) {
    return CustomException(
      cause: map['cause'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomException.fromJson(String source) => CustomException.fromMap(json.decode(source));

  @override
  String toString() => 'CustomException(cause: $cause)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomException &&
      other.cause == cause;
  }

  @override
  int get hashCode => cause.hashCode;
}
