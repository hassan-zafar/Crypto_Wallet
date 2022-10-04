import 'dart:convert';

class SeedPhrase {
  SeedPhrase({required this.status, required this.mnemonic});
  final bool status;
  final String mnemonic;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'mnemonic': mnemonic,
    };
  }

  // ignore: sort_constructors_first
  factory SeedPhrase.fromMap(Map<String, dynamic> map) {
    return SeedPhrase(
      status: map['status'] ?? false,
      mnemonic: map['mnemonic'] ?? '',
    );
  }

  // ignore: sort_constructors_first
  factory SeedPhrase.fromJson(String source) =>
      SeedPhrase.fromMap(json.decode(source));
}
