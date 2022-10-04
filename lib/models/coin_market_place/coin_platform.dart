class CoinPlatform {
  CoinPlatform({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.tokenAddress,
  });

  int id;
  String name;
  String symbol;
  String slug;
  String tokenAddress;

  // ignore: sort_constructors_first
  factory CoinPlatform.fromMap(Map<String, dynamic> json) => CoinPlatform(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        slug: json['slug'],
        tokenAddress: json['token_address'],
      );
}
