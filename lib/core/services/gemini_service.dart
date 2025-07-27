import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config_service.dart';

class GeminiService {
  String? _endpoint;
  String? _projectId;
  final String _apiKey = 'AIzaSyBpgo4ZxILvBHKtmzSNngP_LnJupLN4EG0'; 

  Future<void> init() async {
    _projectId = await ConfigService.getProjectId();
    const location = 'us-central1';
    _endpoint =
        'https://vertexai.googleapis.com/v1/projects/$_projectId/locations/$location/publishers/google/models/gemini:predict';
  }

  Future<String> diagnoseDisease(String imagePath) async {
    if (_endpoint == null) await init();

    final uri = Uri.parse('$_endpoint?key=$_apiKey');

    final imageBytes = await _imageToBase64(imagePath);

    final requestBody = {
      "instances": [
        {
          "prompt": "Diagnose the plant disease from this image",
          "image": {
            "bytesBase64Encoded": imageBytes,
          }
        }
      ]
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['predictions'][0]['content']; // Update if the response differs
    } else {
      return 'Error: ${response.statusCode} - ${response.body}';
    }
  }

  Future<String> _imageToBase64(String imagePath) async {
    final bytes = await http.readBytes(Uri.file(imagePath));
    return base64Encode(bytes);
  }
}
