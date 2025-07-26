import 'package:http/http.dart' as http;
import 'dart:convert';

class MarketApiService {
  Future<Map<String, dynamic>> fetchMarketPrices(String crop) async {
    final response = await http.get(
      Uri.parse('https://api.agmarket.nic.in/marketdata?crop=$crop'),
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}