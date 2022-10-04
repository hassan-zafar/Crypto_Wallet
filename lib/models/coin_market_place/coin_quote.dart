class CoinQuote {
  CoinQuote({required this.usd});

  CoinInUSD usd;

  // ignore: sort_constructors_first
  factory CoinQuote.fromMap(Map<String, dynamic> json) => CoinQuote(
        usd: CoinInUSD.fromMap(json['USD']),
      );
}

class CoinInUSD {
  CoinInUSD({
    required this.price,
    required this.volume24H,
    required this.volumeChange24H,
    required this.percentChange1H,
    required this.percentChange24H,
    required this.percentChange7D,
    required this.percentChange30D,
    required this.percentChange60D,
    required this.percentChange90D,
    required this.marketCap,
    required this.marketCapDominance,
    required this.fullyDilutedMarketCap,
    required this.tvl,
    required this.lastUpdated,
  });

  double price;
  double volume24H;
  double volumeChange24H;
  double percentChange1H;
  double percentChange24H;
  double percentChange7D;
  double percentChange30D;
  double percentChange60D;
  double percentChange90D;
  double marketCap;
  double marketCapDominance;
  double fullyDilutedMarketCap;
  double? tvl;
  DateTime lastUpdated;

  // ignore: sort_constructors_first
  factory CoinInUSD.fromMap(Map<String, dynamic> json) => CoinInUSD(
        price: json['price'].toDouble(),
        volume24H: json['volume_24h'].toDouble(),
        volumeChange24H: json['volume_change_24h'].toDouble(),
        percentChange1H: json['percent_change_1h'].toDouble(),
        percentChange24H: json['percent_change_24h'].toDouble(),
        percentChange7D: json['percent_change_7d'].toDouble(),
        percentChange30D: json['percent_change_30d'].toDouble(),
        percentChange60D: json['percent_change_60d'].toDouble(),
        percentChange90D: json['percent_change_90d'].toDouble(),
        marketCap: json['market_cap'].toDouble(),
        marketCapDominance: json['market_cap_dominance'].toDouble(),
        fullyDilutedMarketCap: json['fully_diluted_market_cap'].toDouble(),
        tvl: json['tvl'],
        lastUpdated: DateTime.parse(json['last_updated']),
      );
}
