import 'package:http/http.dart' as http;
import 'dart:convert';

class SchemeService {
  final String _projectId = 'project-kisan-32118';
  final String _location = 'us-central1';
  final String _apiKey = 'AIzaSyBpgo4ZxILvBHKtmzSNngP_LnJupLN4EG0'; // ⚠️ Move to secure storage

  Future<String> getSchemeInfo(String query) async {
    final endpoint =
        'https://vertexai.googleapis.com/v1/projects/$_projectId/locations/$_location/publishers/google/models/gemini:predict?key=$_apiKey';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "instances": [
          {
            "prompt": "Tell me in simple language about this government scheme: $query"
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['predictions'][0]['content'] ?? 'No response from Gemini.';
    } else {
      return 'Error: ${response.statusCode} - ${response.body}';
    }
  }
}
