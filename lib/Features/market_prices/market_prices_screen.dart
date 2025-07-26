import 'package:flutter/material.dart';
import '../../core/services/market_api_service.dart';

class MarketPricesScreen extends StatefulWidget {
  @override
  _MarketPricesScreenState createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  final MarketApiService _marketApiService = MarketApiService();
  String _priceInfo = '';

  Future<void> _getPrice(String crop) async {
    var data = await _marketApiService.fetchMarketPrices(crop);
    setState(() {
      _priceInfo = data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Market Prices')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _getPrice('tomato'),
            child: Text('Get Tomato Price'),
          ),
          Text(_priceInfo),
        ],
      ),
    );
  }
}
