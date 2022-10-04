import 'dart:convert';

// To parse this JSON data, do
//
//     final coin = coinFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Coin {

    factory Coin.fromJson(String str) => Coin.fromMap(json.decode(str));

    factory Coin.fromMap(Map<String, dynamic> json) => Coin(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image'],
        currentPrice: json['current_price']?.toDouble(),
        marketCap: json['market_cap'],
        marketCapRank: json['market_cap_rank'],
        fullyDilutedValuation: json['fully_diluted_valuation'] == null ? null : json['fully_diluted_valuation'],
        totalVolume: json['total_volume']?.toDouble(),
        high24H: json['high_24h']?.toDouble(),
        low24H: json['low_24h']?.toDouble(),
        priceChange24H: json['price_change_24h']?.toDouble(),
        priceChangePercentage24H: json['price_change_percentage_24h']?.toDouble(),
        marketCapChange24H: json['market_cap_change_24h']?.toDouble(),
        marketCapChangePercentage24H: json['market_cap_change_percentage_24h']?.toDouble(),
        circulatingSupply: json['circulating_supply']?.toDouble(),
        totalSupply: json['total_supply'] == null ? null : json['total_supply']?.toDouble(),
        maxSupply: json['max_supply'] == null ? null : json['max_supply']?.toDouble(),
        ath: json['ath']?.toDouble(),
        athChangePercentage: json['ath_change_percentage']?.toDouble(),
        athDate: DateTime.parse(json['ath_date']),
        atl: json['atl']?.toDouble(),
        atlChangePercentage: json['atl_change_percentage']?.toDouble(),
        atlDate: DateTime.parse(json['atl_date']),
        roi: json['roi'] == null ? null : Roi.fromMap(json['roi']),
        lastUpdated: DateTime.parse(json['last_updated']),
        priceChangePercentage24HInCurrency: json['price_change_percentage_24h_in_currency']?.toDouble(),
    );
    Coin({
        required this.id,
        required this.symbol,
        required this.name,
        required this.image,
        required this.currentPrice,
        required this.marketCap,
        required this.marketCapRank,
        required this.fullyDilutedValuation,
        required this.totalVolume,
        required this.high24H,
        required this.low24H,
        required this.priceChange24H,
        required this.priceChangePercentage24H,
        required this.marketCapChange24H,
        required this.marketCapChangePercentage24H,
        required this.circulatingSupply,
        required this.totalSupply,
        required this.maxSupply,
        required this.ath,
        required this.athChangePercentage,
        required this.athDate,
        required this.atl,
        required this.atlChangePercentage,
        required this.atlDate,
        required this.roi,
        required this.lastUpdated,
        // required this.sparklineIn7D,
        required this.priceChangePercentage24HInCurrency,
    });

    final String? id;
    final String? symbol;
    final String? name;
    final String? image;
    final double? currentPrice;
    final int? marketCap;
    final int? marketCapRank;
    final int? fullyDilutedValuation;
    final double? totalVolume;
    final double? high24H;
    final double? low24H;
    final double? priceChange24H;
    final double? priceChangePercentage24H;
    final double? marketCapChange24H;
    final double? marketCapChangePercentage24H;
    final double? circulatingSupply;
    final double? totalSupply;
    final double? maxSupply;
    final double? ath;
    final double? athChangePercentage;
    final DateTime? athDate;
    final double? atl;
    final double? atlChangePercentage;
    final DateTime? atlDate;
    final Roi? roi;
    final DateTime? lastUpdated;
    // final SparklineIn7D? sparklineIn7D;
    final double? priceChangePercentage24HInCurrency;

    Coin copyWith({
        String? id,
        String? symbol,
        String? name,
        String? image,
        double? currentPrice,
        int? marketCap,
        int? marketCapRank,
        int? fullyDilutedValuation,
        double? totalVolume,
        double? high24H,
        double? low24H,
        double? priceChange24H,
        double? priceChangePercentage24H,
        double? marketCapChange24H,
        double? marketCapChangePercentage24H,
        double? circulatingSupply,
        double? totalSupply,
        double? maxSupply,
        double? ath,
        double? athChangePercentage,
        DateTime? athDate,
        double? atl,
        double? atlChangePercentage,
        DateTime? atlDate,
        Roi? roi,
        DateTime? lastUpdated,
        SparklineIn7D? sparklineIn7D,
        double? priceChangePercentage24HInCurrency,
    }) => 
        Coin(
            id: id ?? id,
            symbol: symbol ?? symbol,
            name: name ?? name,
            image: image ?? image,
            currentPrice: currentPrice ?? currentPrice,
            marketCap: marketCap ?? marketCap,
            marketCapRank: marketCapRank ?? marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation ?? fullyDilutedValuation,
            totalVolume: totalVolume ?? totalVolume,
            high24H: high24H ?? high24H,
            low24H: low24H ?? low24H,
            priceChange24H: priceChange24H ?? priceChange24H,
            priceChangePercentage24H: priceChangePercentage24H ?? priceChangePercentage24H,
            marketCapChange24H: marketCapChange24H ?? marketCapChange24H,
            marketCapChangePercentage24H: marketCapChangePercentage24H ?? marketCapChangePercentage24H,
            circulatingSupply: circulatingSupply ?? circulatingSupply,
            totalSupply: totalSupply ?? totalSupply,
            maxSupply: maxSupply ?? maxSupply,
            ath: ath ?? ath,
            athChangePercentage: athChangePercentage ?? athChangePercentage,
            athDate: athDate ?? athDate,
            atl: atl ?? atl,
            atlChangePercentage: atlChangePercentage ?? atlChangePercentage,
            atlDate: atlDate ?? atlDate,
            roi: roi ?? roi,
            lastUpdated: lastUpdated ?? lastUpdated,
            // sparklineIn7D: sparklineIn7D ?? sparklineIn7D,
            priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency ?? priceChangePercentage24HInCurrency,
        );

    String toJson() => json.encode(toMap());

    Map<String, dynamic> toMap() => {
        'id': id,
        'symbol': symbol,
        'name': name,
        'image': image,
        'current_price': currentPrice,
        'market_cap': marketCap,
        'market_cap_rank': marketCapRank,
        'fully_diluted_valuation': fullyDilutedValuation == null ? null : fullyDilutedValuation,
        'total_volume': totalVolume,
        'high_24h': high24H,
        'low_24h': low24H,
        'price_change_24h': priceChange24H,
        'price_change_percentage_24h': priceChangePercentage24H,
        'market_cap_change_24h': marketCapChange24H,
        'market_cap_change_percentage_24h': marketCapChangePercentage24H,
        'circulating_supply': circulatingSupply,
        'total_supply': totalSupply == null ? null : totalSupply,
        'max_supply': maxSupply == null ? null : maxSupply,
        'ath': ath,
        'ath_change_percentage': athChangePercentage,
        'ath_date': athDate!.toIso8601String(),
        'atl': atl,
        'atl_change_percentage': atlChangePercentage,
        'atl_date': atlDate!.toIso8601String(),
        'roi': roi == null ? null : roi!.toMap(),
        'last_updated': lastUpdated!.toIso8601String(),
        // 'sparkline_in_7d': sparklineIn7D!.toMap(),
        'price_change_percentage_24h_in_currency': priceChangePercentage24HInCurrency,
    };
}

class Roi {

    factory Roi.fromMap(Map<String, dynamic> json) => Roi(
        times: json['times']?.toDouble(),
        currency: currencyValues.mapValue[json['currency']],
        percentage: json['percentage']?.toDouble(),
    );

    factory Roi.fromJson(String str) => Roi.fromMap(json.decode(str));
    Roi({
        required this.times,
        required this.currency,
        required this.percentage,
    });

    final double? times;
    final Currency? currency;
    final double? percentage;

    Roi copyWith({
        double? times,
        Currency? currency,
        double? percentage,
    }) => 
        Roi(
            times: times ?? this.times,
            currency: currency ?? this.currency,
            percentage: percentage ?? this.percentage,
        );

    String toJson() => json.encode(toMap());

    Map<String, dynamic> toMap() => {
        'times': times,
        // 'currency': currencyValues.reverse[currency],
        'percentage': percentage,
    };
}

enum Currency { BTC, USD, ETH }

final CurrencyEnumValues<Currency> currencyValues = CurrencyEnumValues({
    'btc': Currency.BTC,
    'eth': Currency.ETH,
    'usd': Currency.USD
});

class SparklineIn7D {

    factory SparklineIn7D.fromMap(Map<String, dynamic> json) => SparklineIn7D(
        price: List<double>.from(json['price'].mapValue((x) => x?.toDouble())),
    );

    factory SparklineIn7D.fromJson(String str) => SparklineIn7D.fromMap(json.decode(str));
    SparklineIn7D({
        required this.price,
    });

    final List<double> price;

    SparklineIn7D copyWith({
        required List<double> price,
    }) => 
        SparklineIn7D(
            price: price,
        );

    String toJson() => json.encode(toMap());

    Map<String, dynamic> toMap() => {
        'price': List<dynamic>.from(price.map((double x) => x)),
    };
}

class CurrencyEnumValues<T> {

    CurrencyEnumValues(this.mapValue);
    Map<String, T> mapValue;
    Map<T, String> reverseMap={};

    // Map<T, String> get reverse {
    //     reverseMap ??= mapValue.map((String k, v) => new MapEntry(v, k));
    //     return reverseMap;
    // }
}


// class Coin {
//   Coin({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.image,
//     required this.currentPrice,
//     required this.totalVolume,
//     required this.priceChange24H,
//     required this.priceChangePercentage24H,
//     required this.priceChangePercentage7D,
//     required this.priceChangePercentage14D,
//     required this.priceChangePercentage30D,
//     required this.priceChangePercentage60D,
//     required this.priceChangePercentage200D,
//   });

//   final String id;
//   final String symbol;
//   final String name;
//   final String image;
//   final double currentPrice;
//   final int totalVolume;
//   final double priceChange24H;
//   final double priceChangePercentage24H;
//   final double priceChangePercentage7D;
//   final double priceChangePercentage14D;
//   final double priceChangePercentage30D;
//   final double priceChangePercentage60D;
//   final double priceChangePercentage200D;

//   // ignore: sort_constructors_first
//   factory Coin.fromJson(Map<String, dynamic> json) {
//     return Coin(
//       id: json['id'],
//       symbol: json['symbol'],
//       name: json['name'],
//       image: json['image'],
//       currentPrice: json['current_price'] + 0.0,
//       totalVolume: json['total_volume'],
//       priceChange24H: json['price_change_24h'] + 0.0,
//       priceChangePercentage24H: json['price_change_percentage_24h'] + 0.0,
//       priceChangePercentage7D: json['price_change_percentage_7d'] + 0.0,
//       priceChangePercentage14D: json['price_change_percentage_14d'] + 0.0,
//       priceChangePercentage30D: json['price_change_percentage_30d'] + 0.0,
//       priceChangePercentage60D: json['price_change_percentage_60d'] + 0.0,
//       priceChangePercentage200D: json['price_change_percentage_200d'] + 0.0,
//     );
//   }

//   static Coin fromMap(String str) => Coin.fromJson(json.decode(str));
// }
