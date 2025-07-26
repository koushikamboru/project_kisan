import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ConfigService {
  static Future<Map<String, dynamic>> loadServiceAccount() async {
    final configString = await rootBundle.loadString('assets/project-kisan-32118-6d3176509bf5.json');
    return json.decode(configString);
  }

  static Future<String> getProjectId() async {
    final config = await loadServiceAccount();
    return config['project_id'];
  }

  static Future<String> getPrivateKey() async {
    final config = await loadServiceAccount();
    return config['private_key'];
  }

  static Future<String> getClientEmail() async {
    final config = await loadServiceAccount();
    return config['client_email'];
  }
}