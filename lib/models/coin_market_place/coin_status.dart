class CoinStatus {
  CoinStatus({
    required this.timestamp,
    required this.errorCode,
    required this.errorMessage,
    required this.elapsed,
    required this.creditCount,
  });

  DateTime timestamp;
  int errorCode;
  String? errorMessage;
  int elapsed;
  int creditCount;

  // ignore: sort_constructors_first
  factory CoinStatus.fromMap(Map<String, dynamic> json) => CoinStatus(
        timestamp: DateTime.parse(json['timestamp']),
        errorCode: json['error_code'],
        errorMessage: json['error_message'],
        elapsed: json['elapsed'],
        creditCount: json['credit_count'],
      );
}
