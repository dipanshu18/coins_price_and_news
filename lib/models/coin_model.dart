// {
//     "id": "bitcoin",
//     "symbol": "btc",
//     "name": "Bitcoin",
//     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
//     "current_price": 69354,
//     "market_cap": 1364609209362,
//     "market_cap_rank": 1,
//     "fully_diluted_valuation": 1456443669809,
//     "total_volume": 16359080392,
//     "high_24h": 69711,
//     "low_24h": 67612,
//     "price_change_24h": 1587.87,
//     "price_change_percentage_24h": 2.34314,
//     "market_cap_change_24h": 31312948820,
//     "market_cap_change_percentage_24h": 2.34854,
//     "circulating_supply": 19675868,
//     "total_supply": 21000000,
//     "max_supply": 21000000,
//     "ath": 73738,
//     "ath_change_percentage": -5.92272,
//     "ath_date": "2024-03-14T07:10:36.635Z",
//     "atl": 67.81,
//     "atl_change_percentage": 102203.0099,
//     "atl_date": "2013-07-06T00:00:00.000Z",
//     "roi": null,
//     "last_updated": "2024-04-07T13:00:13.277Z"
//   },

class CoinModel {
  final String symbol;
  final String name;
  final String image;
  final num currentPrice;

  CoinModel({
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
  });
}
